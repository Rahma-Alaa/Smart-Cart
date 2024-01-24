class GetMsg {
  late final String? message;

  GetMsg.fromJson(Map<String, dynamic> json) {
    message = json["message"];
  }
}
