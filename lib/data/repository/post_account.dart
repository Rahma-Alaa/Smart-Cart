import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/get_info.dart';

Future<GetInfo> createAccount(
    String userName, String email, String password) async {
  final response = await http.post(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[AccountController]/CreateAccount?userName=$userName&email=$email&password=$password'));
  return GetInfo.fromJson(jsonDecode(response.body));
}

// Future<GetSignIn> signIn(String email, String password) async {
  // final response = await http.post(Uri.parse(
      // 'https://smartcartapplback.azurewebsites.net/[SignInController]/SignIn?email=$email&password=$password'));
  // return GetSignIn.fromJson(jsonDecode(response.body));
// }
// class Account {
//   final String userName;
//   final String email;
//   final String password;

//   const Account(
//       {required this.userName, required this.email, required this.password});

//   factory Account.fromJson(Map<String, dynamic> json) {
//     return Account(
//       userName: json['userName'],
//       email: json['email'],
//       password: json['password'],
//     );
//   }
// }
