import 'package:http/http.dart' as http;

deleteCard(String cardId) async {
  await http.delete(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[CardController]/DeleteCard?cardId=$cardId'));
}
