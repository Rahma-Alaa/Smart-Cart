class GetSignIn {
  late final String? email;
  late final String? password;
  late final int? id;

  GetSignIn.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    id = json["id"];
  }
}
