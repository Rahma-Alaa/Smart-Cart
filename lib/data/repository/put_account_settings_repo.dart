import 'package:http/http.dart' as http;

putName(int? id, String? name) async {
  String url =
      'https://smartcartapplback.azurewebsites.net/[AccountSettingsController]/UpdateName?userId=$id&newuserName=$name';
  await http.put(Uri.parse(url));
}

putPassword(int? id, String? password) async {
  String url =
      'https://smartcartapplback.azurewebsites.net/[AccountSettingsController]/UpdatePassword?userId=$id&newPassword=$password';
  await http.put(Uri.parse(url));
}
