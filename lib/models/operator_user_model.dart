class OperatorUser {
  int? id;
  OperatorUserAttributes? attributes;

  OperatorUser({this.id, this.attributes});

  OperatorUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new OperatorUserAttributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class OperatorUserAttributes {
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;

  OperatorUserAttributes(
      {this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt});

  OperatorUserAttributes.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
