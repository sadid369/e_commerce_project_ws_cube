import 'package:e_commerce_project_ws_cube/constants/error_handaling.dart';
import 'package:e_commerce_project_ws_cube/constants/global_variables.dart';
import 'package:e_commerce_project_ws_cube/constants/utils.dart';
import 'package:e_commerce_project_ws_cube/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
