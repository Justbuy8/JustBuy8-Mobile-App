// ignore_for_file: file_names

class CategoryModel {
  String? catId;
  String? catName;
  String? cateImage;
  String? productCount;

  CategoryModel({
    this.catId,
    this.catName,
    this.cateImage,
    this.productCount,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['CatId'].toString();
    catName = json['CatName'];
    cateImage = json['CateImage'];
    productCount = json['productCount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CatId'] = catId;
    data['CatName'] = catName;
    data['CateImage'] = cateImage;
    data['productCount'] = productCount;
    return data;
  }
}
