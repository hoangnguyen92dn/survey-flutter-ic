import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_flutter_ic/theme/dimens.dart';

showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: fontSize16);
}
