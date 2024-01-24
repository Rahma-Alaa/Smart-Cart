import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/get_info.dart';

Future<GetInfo> signin(String email, String password) async {
  final response = await http.get(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[SignInController]/SignIn?email=$email&password=$password'));
  return GetInfo.fromJson(jsonDecode(response.body));
}
