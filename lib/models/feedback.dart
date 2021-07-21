class FeedbackList {
  String message;
  List<Feedbacks> feedbacks;

  FeedbackList({this.message, this.feedbacks});

  FeedbackList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['feedbacks'] != null) {
      feedbacks = [];
      json['feedbacks'].forEach((v) {
        feedbacks.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedbacks {
  String id;
  String user;
  String message;
  double rating;
  String deliveryBoy;
  String timeStamp;

  Feedbacks({
    this.id,
    this.user,
    this.message,
    this.rating,
    this.deliveryBoy,
    this.timeStamp,
  });

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    message = json['message'];
    rating = json['rating'].toDouble();
    deliveryBoy = json['deliveryBoy'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['user'] = this.user;
    data['message'] = this.message;
    data['rating'] = this.rating;
    data['deliveryBoy'] = this.deliveryBoy;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}
