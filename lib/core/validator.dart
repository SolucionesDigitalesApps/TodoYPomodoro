
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// Returns an error message if the input [input] is not a valid email, or an empty string if it is valid.
/// 
/// An email is considered valid if it matches the following regular expression:
/// ```
/// ^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+
/// ```
/// 
/// The function checks if the input matches the regular expression using the hasMatch method. If the input does not match, the function returns an error message indicating that the input is not a valid email. If the input matches the regular expression, the function returns an empty string, indicating that the input is a valid email.
String emailValidator(BuildContext context, String input) {
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
     .hasMatch(input);
  if (!emailValid) {
    return FlutterI18n.translate(context, "validators.invalid_email");
  }
  return "";
}

/// Returns an error message if the input [input] is not a valid password, or an empty string if it is valid.
///
/// A password is considered valid if it is not empty. If the input is empty, the function returns an error message indicating that the input is not a valid password.
String passwordValidator(BuildContext context, String input) {
  if (input.isEmpty) {
    return FlutterI18n.translate(context, "validators.invalid_password");
  }
  return "";
}