class GetInvoice {
  late final String? price;
  late final String? date;
  late final int? id;

  GetInvoice.fromJson(Map<String, dynamic> json) {
    price = json["price"];
    date = json["date"];
    id = json["id"];
  }
}
