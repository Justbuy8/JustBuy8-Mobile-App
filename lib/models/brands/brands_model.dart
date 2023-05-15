class BrandsModel {
  int? brandId;
  String? brandName;
  String? brandImage;

  BrandsModel({this.brandId, this.brandName, this.brandImage});

  BrandsModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_Id'];
    brandName = json['brand_Name'];
    brandImage = json['brand_Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_Id'] = brandId;
    data['brand_Name'] = brandName;
    data['brand_Image'] = brandImage;
    return data;
  }
}
