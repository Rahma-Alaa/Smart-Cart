import 'package:http/http.dart' as http;

putCheckout(int? id, String? qr) async {
  String url =
      'https://smartcartapplback.azurewebsites.net/Product/CheckoutCart?cartId=$qr&userId=$id';
  await http.put(Uri.parse(url));
}
