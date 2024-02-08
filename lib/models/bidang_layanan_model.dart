import 'package:langgam_project/models/gambar_model.dart';

class BidangLayanan {
  int? id;
  Attributes? attributes;

  BidangLayanan({this.id, this.attributes});

  BidangLayanan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
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

class Attributes {
  String? slug;
  String? intro;
  String? createdAt;
  String? updatedAt;
  String? judul;
  Gambar? gambar;

  Attributes({
    this.slug,
    this.intro,
    this.createdAt,
    this.updatedAt,
    this.judul,
    this.gambar,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    intro = json['intro'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    judul = json['judul'];
    gambar =
        json['gambar'] != null ? new Gambar.fromJson(json['gambar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['intro'] = this.intro;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['judul'] = this.judul;
    if (this.gambar != null) {
      data['gambar'] = this.gambar!.toJson();
    }
    return data;
  }
}
