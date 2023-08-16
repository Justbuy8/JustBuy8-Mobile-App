class ShopDetailsModel {
  int? id;
  String? name;
  String? sellerId;
  String? image;
  String? banner;
  String? reviews;
  int? orders;
  String? memberSince;
  String? address;
  String? email;
  String? contact;

  ShopDetailsModel(
      {this.id,
      this.name,
      this.sellerId,
      this.image,
      this.banner,
      this.reviews,
      this.orders,
      this.memberSince,
      this.address,
      this.email,
      this.contact});

  ShopDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellerId = json['Seller_id'];
    image = json['image'];
    banner = json['banner'];
    reviews = json['Reviews'];
    orders = json['Orders'];
    memberSince = json['Member_since'];
    address = json['Address'];
    email = json['Email'];
    contact = json['Contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['Seller_id'] = this.sellerId;
    data['image'] = this.image;
    data['banner'] = this.banner;
    data['Reviews'] = this.reviews;
    data['Orders'] = this.orders;
    data['Member_since'] = this.memberSince;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['Contact'] = this.contact;
    return data;
  }
}
