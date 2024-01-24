class GetInfo {
  late final String? success;
  late final int? id;

  GetInfo.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    id = json["userId"];
  }
}
