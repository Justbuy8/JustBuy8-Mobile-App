// ignore_for_file: file_names, prefer_collection_literals
class SubCategoryModel {
  int? subCatId;
  String? subCatName;
  List<Child>? child;

  SubCategoryModel({this.subCatId, this.subCatName, this.child});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    subCatId = json['Sub_CatId'];
    subCatName = json['Sub_CatName'];
    if (json['Child'] != null) {
      child = <Child>[];
      json['Child'].forEach((v) {
        child!.add(Child.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Sub_CatId'] = subCatId;
    data['Sub_CatName'] = subCatName;
    if (child != null) {
      data['Child'] = child!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  int? childCatId;
  String? childCatName;

  Child({this.childCatId, this.childCatName});

  Child.fromJson(Map<String, dynamic> json) {
    childCatId = json['Child_CatId'];
    childCatName = json['Child_CatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Child_CatId'] = childCatId;
    data['Child_CatName'] = childCatName;
    return data;
  }
}
