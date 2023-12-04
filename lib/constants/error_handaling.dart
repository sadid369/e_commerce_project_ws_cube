import 'dart:convert';

import 'package:e_commerce_project_ws_cube/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showMySnackBar(context: context, text: jsonDecode(response.body)['msg']);
      break;
    case 500:
      showMySnackBar(
          context: context, text: jsonDecode(response.body)['error']);
      break;
    default:
      showMySnackBar(context: context, text: response.body);
  }
}
