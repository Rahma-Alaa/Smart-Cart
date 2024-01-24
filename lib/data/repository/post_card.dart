import 'package:http/http.dart' as http;

createCard(String cardholder, String cardnumber, String expirationdate,
    String cvv, String userId) async {
  await http.post(Uri.parse(
      'https://smartcartapplback.azurewebsites.net/[CardController]/AddCard?cardholder=$cardholder&cardnumber=$cardnumber&expirationdate=$expirationdate&cvv=$cvv&userId=$userId'));
}
