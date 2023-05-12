class TopCategoriesModel {
  int? catId;
  String? catName;
  String? cateImage;

  TopCategoriesModel({this.catId, this.catName, this.cateImage});

  TopCategoriesModel.fromJson(Map<String, dynamic> json) {
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
