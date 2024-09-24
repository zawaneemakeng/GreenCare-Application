class Product {
  int? id;
  String? name;
  int? quantity;
  double? price;
  double? total;
  bool status;

  Product(
      {this.id,
      this.name,
      this.quantity,
      this.price,
      this.total,
      required this.status});

  // conv to json
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'total': total,
      'status': status ? 1 : 0
    };
    return map;
  }
}
