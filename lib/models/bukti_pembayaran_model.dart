class BuktiPembayaran {
  BuktiPembayaranData? data;

  BuktiPembayaran({this.data});

  BuktiPembayaran.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new BuktiPembayaranData.fromJson(json['data'])
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

class BuktiPembayaranData {
  int? id;
  BuktiPembayaranAttributes? attributes;

  BuktiPembayaranData({this.id, this.attributes});

  BuktiPembayaranData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new BuktiPembayaranAttributes.fromJson(json['attributes'])
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

class BuktiPembayaranAttributes {
  String? name;
  String? ext;
  String? url;
  String? createdAt;
  String? updatedAt;

  BuktiPembayaranAttributes(
      {this.name, this.ext, this.url, this.createdAt, this.updatedAt});

  BuktiPembayaranAttributes.fromJson(Map<String, dynamic> json) {
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
