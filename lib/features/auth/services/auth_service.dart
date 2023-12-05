import 'dart:convert';

import 'package:e_commerce_project_ws_cube/constants/error_handaling.dart';
import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/constants/utils.dart';
import 'package:e_commerce_project_ws_cube/features/home/screens/home_screens.dart';
import 'package:e_commerce_project_ws_cube/model/user.dart';
import 'package:e_commerce_project_ws_cube/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //sign up user

  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
      );

      http.Response res = await http.post(
        Uri.parse("${uri}/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showMySnackBar(
              context: context,
              text: 'Account created, Login with the same credentials');
        },
      );
    } catch (e) {
      showMySnackBar(context: context, text: e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("${uri}/api/signin"),
        body: jsonEncode({
          'email': email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          context.read<UserProvider>().setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreens.routeName,
            (route) => false,
          );
          //
          //
          print(jsonDecode(res.body)['token']);
          print(jsonDecode(res.body));

          showMySnackBar(context: context, text: 'Successfully Logged In');
        },
      );
    } catch (e) {
      showMySnackBar(context: context, text: e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', "");
      }
      http.Response tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {}
      // http.Response res = await http.post(
      //   Uri.parse("${uri}/api/signin"),
      //   body: jsonEncode({
      //     'email': email,
      //     "password": password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () async {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     context.read<UserProvider>().setUser(res.body);
      //     await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
      //     Navigator.pushNamedAndRemoveUntil(
      //       context,
      //       HomeScreens.routeName,
      //       (route) => false,
      //     );
      //     //
      //     //
      //     print(jsonDecode(res.body)['token']);
      //     print(jsonDecode(res.body));

      //     showMySnackBar(context: context, text: 'Successfully Logged In');
      //   },
      // );
    } catch (e) {
      showMySnackBar(context: context, text: e.toString());
    }
  }
}
