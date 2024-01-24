import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/get_msg.dart';

addInvoice(String amount, String cartId, String userId, String date) async {
  final response = await http.post(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[InvoiceController]/AddInvoice?amount=$amount&cartId=$cartId&userId=$userId&date=$date'));
  return GetMsg.fromJson(jsonDecode(response.body));
}
