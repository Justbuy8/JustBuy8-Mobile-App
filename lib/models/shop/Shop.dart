class Shop {
  int? id;
  String? name;
  String? sellerId;
  String? image;
  String? reviews;

  Shop({this.id, this.name, this.sellerId, this.image, this.reviews});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellerId = json['Seller_id'];
    image = json['image'];
    reviews = json['Reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['Seller_id'] = this.sellerId;
    data['image'] = this.image;
    data['Reviews'] = this.reviews;
    return data;
  }
}
