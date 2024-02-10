class SuratPermintaan {
  SuratPermintaanData? data;

  SuratPermintaan({this.data});

  SuratPermintaan.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SuratPermintaanData.fromJson(json['data'])
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

class SuratPermintaanData {
  int? id;
  SuratPermintaanAttributes? attributes;

  SuratPermintaanData({this.id, this.attributes});

  SuratPermintaanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new SuratPermintaanAttributes.fromJson(json['attributes'])
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

class SuratPermintaanAttributes {
  String? name;
  String? ext;
  String? url;
  String? createdAt;
  String? updatedAt;

  SuratPermintaanAttributes(
      {this.name, this.ext, this.url, this.createdAt, this.updatedAt});

  SuratPermintaanAttributes.fromJson(Map<String, dynamic> json) {
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
