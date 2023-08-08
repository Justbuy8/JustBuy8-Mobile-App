class ReviewModel {
  String? fName;
  String? lName;
  String? image;
  String? comment;
  String? rating;
  String? timePassed;

  ReviewModel(
      {this.fName,
      this.lName,
      this.image,
      this.comment,
      this.rating,
      this.timePassed});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];
    comment = json['comment'];
    rating = json['rating'];
    timePassed = json['time_passed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['image'] = this.image;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['time_passed'] = this.timePassed;
    return data;
  }
}
