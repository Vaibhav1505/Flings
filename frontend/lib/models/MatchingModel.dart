class MatchingModel {
  String? sId;
  String? userId;
  String? userName;
  String? gender;
  String? lastMessage;

  MatchingModel(
      {this.sId, this.userId, this.userName, this.gender, this.lastMessage});

  MatchingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userName = json['userName'];
    gender = json['gender'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['gender'] = gender;
    data['lastMessage'] = lastMessage;
    return data;
  }
}
