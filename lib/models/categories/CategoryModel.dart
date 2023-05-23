// ignore_for_file: file_names

class CategoriesModel {
  String? catId;
  String? catName;
  String? cateImage;
  int? productCount;

  CategoriesModel({
    this.catId,
    this.catName,
    this.cateImage,
    this.productCount,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    catId = json['CatId'].toString();
    catName = json['CatName'];
    cateImage = json['CateImage'];
    productCount = json['ProductCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CatId'] = catId;
    data['CatName'] = catName;
    data['CateImage'] = cateImage;
    data['ProductCount'] = productCount;
    return data;
  }
}
