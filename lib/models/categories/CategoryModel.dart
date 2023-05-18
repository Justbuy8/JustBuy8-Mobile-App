// ignore_for_file: file_names

class CategoriesModel {
  int? catId;
  String? catName;
  String? cateImage;

  CategoriesModel({this.catId, this.catName, this.cateImage});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    catId = json['CatId'];
    catName = json['CatName'];
    cateImage = json['CateImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CatId'] = catId;
    data['CatName'] = catName;
    data['CateImage'] = cateImage;
    return data;
  }
}
