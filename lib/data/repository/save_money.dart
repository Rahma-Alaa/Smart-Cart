import 'package:http/http.dart' as http;

setMoney(String amount, String userId) async {
  String url =
      'https://smartcartapplback.azurewebsites.net/[saveMoneyController]/AddWalletAmount?walletAmount=$amount&userid=$userId';

  await http.post(Uri.parse(url));
}

Future<String> getMoney(String userId) async {
  final response = await http.get(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[yourCartController]/WalletAmount?userid=$userId'));
  return response.body;
}
