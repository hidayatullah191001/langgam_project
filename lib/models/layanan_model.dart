import 'package:langgam_project/models/bidang_layanan_model.dart';
import 'package:langgam_project/models/gambar_model.dart';
import 'package:langgam_project/models/konten_model.dart';

class Layanan {
  int? id;
  Attributes? attributes;

  Layanan({this.id, this.attributes});

  Layanan.fromJson(Map<String, dynamic> json) {
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
  List<Konten>? konten;
  int? harga;
  String? satuan;
  Gambar? gambar;
  BidangLayanan? bidangLayanan;

  Attributes({
    this.slug,
    this.intro,
    this.createdAt,
    this.updatedAt,
    this.judul,
    this.konten,
    this.harga,
    this.satuan,
    this.gambar,
    this.bidangLayanan,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    intro = json['intro'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    judul = json['judul'];
    if (json['konten'] != null) {
      konten = <Konten>[];
      json['konten'].forEach((v) {
        konten!.add(new Konten.fromJson(v));
      });
    }
    harga = json['harga'];
    satuan = json['satuan'];
    gambar =
        json['gambar'] != null ? new Gambar.fromJson(json['gambar']) : null;
    bidangLayanan = json['bidang_layanan'] != null
        ? new BidangLayanan.fromJson(json['bidang_layanan']['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['intro'] = this.intro;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['judul'] = this.judul;
    if (this.konten != null) {
      data['konten'] = this.konten!.map((v) => v.toJson()).toList();
    }
    data['harga'] = this.harga;
    data['satuan'] = this.satuan;
    if (this.gambar != null) {
      data['gambar'] = this.gambar!.toJson();
    }
    if (this.bidangLayanan != null) {
      data['bidang_layanan']['data'] = this.bidangLayanan!.toJson();
    }
    return data;
  }
}
