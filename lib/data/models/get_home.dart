class GetHome {
  late final String? userName;
  late final String? userEmail;
  late final String? profilePictureURL;

  GetHome.fromJson(Map<String, dynamic> json) {
    userName = json["userName"];
    userEmail = json["userEmail"];
    profilePictureURL = json["profilePictureURL"];
  }
}
