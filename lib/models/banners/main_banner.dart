class MainBanner {
  int? id;
  String? imageLink;
  String? url;
  String? resourceType;
  String? resourceId;

  MainBanner(
      {this.id, this.imageLink, this.url, this.resourceType, this.resourceId});

  MainBanner.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    imageLink = json['Image Link'];
    url = json['Url'];
    resourceType = json['Resource Type'];
    resourceId = json['Resource id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Image Link'] = imageLink;
    data['Url'] = url;
    data['Resource Type'] = resourceType;
    data['Resource id'] = resourceId;
    return data;
  }
}
