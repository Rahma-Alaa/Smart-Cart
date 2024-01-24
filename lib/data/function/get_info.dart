import 'package:shared_preferences/shared_preferences.dart';

getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');
  return username!;
}

Future<String> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? email = prefs.getString('email');
  return email!;
}

Future<String> getId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('id');
  return id!;
}

Future<String> getPassword() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? password = prefs.getString('password');
  return password!;
}
