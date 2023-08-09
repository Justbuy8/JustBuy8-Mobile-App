class ProductDetailsModel {
  int? id;
  String? name;
  List<Images>? images;
  String? description;
  String? thumbnail;
  String? unitPrice;
  Vendor? vendor;
  String? discount;
  String? discountType;
  List<ChoiceOptions>? choiceOptions;
  List<Variation>? variation;
  List<Colors>? colors;
  String? totalReviews;
  String? reviewsCount;
  List<Reviews>? reviews;
  String? currentStock;

  ProductDetailsModel(
      {this.id,
      this.name,
      this.images,
      this.description,
      this.thumbnail,
      this.unitPrice,
      this.vendor,
      this.discount,
      this.discountType,
      this.choiceOptions,
      this.variation,
      this.colors,
      this.totalReviews,
      this.reviewsCount,
      this.reviews,
      this.currentStock});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    description = json['description'];
    thumbnail = json['thumbnail'];
    unitPrice = json['unit_price'];
    vendor =
        json['Vendor'] != null ? new Vendor.fromJson(json['Vendor']) : null;
    discount = json['discount'];
    discountType = json['discount_type'];
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(new Variation.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(new Colors.fromJson(v));
      });
    }
    totalReviews = json['total_reviews'];
    reviewsCount = json['reviews_count'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    currentStock = json['current_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['unit_price'] = this.unitPrice;
    if (this.vendor != null) {
      data['Vendor'] = this.vendor!.toJson();
    }
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    }
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    data['total_reviews'] = this.totalReviews;
    data['reviews_count'] = this.reviewsCount;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['current_stock'] = this.currentStock;
    return data;
  }
}

class Images {
  String? image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Vendor {
  String? addedBy;
  String? id;
  int? shopId;
  String? shopName;

  Vendor({this.addedBy, this.id, this.shopId, this.shopName});

  Vendor.fromJson(Map<String, dynamic> json) {
    addedBy = json['added_by'];
    id = json['id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['added_by'] = this.addedBy;
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    return data;
  }
}

class ChoiceOptions {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['options'] = this.options;
    return data;
  }
}

class Variation {
  String? type;
  int? price;
  String? sku;
  int? qty;

  Variation({this.type, this.price, this.sku, this.qty});

  Variation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
    sku = json['sku'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    return data;
  }
}

class Colors {
  String? name;
  String? code;

  Colors({this.name, this.code});

  Colors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class Reviews {
  int? id;
  String? productId;
  String? customerId;
  String? comment;
  String? attachment;
  String? rating;
  String? status;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
      this.productId,
      this.customerId,
      this.comment,
      this.attachment,
      this.rating,
      this.status,
      this.createdAt,
      this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    attachment = json['attachment'];
    rating = json['rating'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['comment'] = this.comment;
    data['attachment'] = this.attachment;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
