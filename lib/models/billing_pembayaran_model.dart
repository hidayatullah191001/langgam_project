class BillingPembayaran {
  BillingPembayaranData? data;

  BillingPembayaran({this.data});

  BillingPembayaran.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new BillingPembayaranData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BillingPembayaranData {
  int? id;
  BillingPembayaranAttributes? attributes;

  BillingPembayaranData({this.id, this.attributes});

  BillingPembayaranData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new BillingPembayaranAttributes.fromJson(json['attributes'])
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

class BillingPembayaranAttributes {
  String? name;
  String? ext;
  String? url;
  String? createdAt;
  String? updatedAt;

  BillingPembayaranAttributes(
      {this.name, this.ext, this.url, this.createdAt, this.updatedAt});

  BillingPembayaranAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    ext = json['ext'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ext'] = this.ext;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
