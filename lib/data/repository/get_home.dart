import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Smarket/data/models/get_msg.dart';
import '../models/get_home.dart';

Future<GetHome> homeInfo(int id) async {
  final response = await http.get(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[AccountController]/GetUserData?id=${id.toString()}'));
  return GetHome.fromJson(jsonDecode(response.body));
}

Future<GetMsg> userImg(int id) async {
  final response = await http.get(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/FileSystem/ReadProfileImage?userId=${id.toString()}'));
  return GetMsg.fromJson(jsonDecode(response.body));
}

Future<GetMsg> productImg(String productId) async {
  final response = await http.get(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/FileSystem/ReadProductImage?productId=$productId'));
  return GetMsg.fromJson(jsonDecode(response.body));
}

Future<GetMsg> userInvoice(int id, int invoiceId) async {
  final response = await http.get(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/FileSystem/ReadInvoicePDF?userId=${id.toString()}&invoiceId=${invoiceId.toString()}'));
  return GetMsg.fromJson(jsonDecode(response.body));
}
