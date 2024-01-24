import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/get_msg.dart';

Future<GetMsg> authQr(String? qr, int id) async {
  final response = await http.post(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/Product/ConnectAccountWithCartQRCode?cartId=$qr&userId=${id.toString()}'));

  return GetMsg.fromJson(jsonDecode(response.body));
}
