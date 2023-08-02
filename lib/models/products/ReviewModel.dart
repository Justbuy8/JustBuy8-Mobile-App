class ReviewModel {
  String? fName;
  String? lName;
  String? image;
  String? comment;
  String? rating;
  TimePassed? timePassed;

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
    timePassed = json['time_passed'] != null
        ? new TimePassed.fromJson(json['time_passed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['image'] = this.image;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    if (this.timePassed != null) {
      data['time_passed'] = this.timePassed!.toJson();
    }
    return data;
  }
}

class TimePassed {
  int? years;
  int? months;
  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  TimePassed(
      {this.years,
      this.months,
      this.days,
      this.hours,
      this.minutes,
      this.seconds});

  TimePassed.fromJson(Map<String, dynamic> json) {
    years = json['years'];
    months = json['months'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['years'] = this.years;
    data['months'] = this.months;
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}
