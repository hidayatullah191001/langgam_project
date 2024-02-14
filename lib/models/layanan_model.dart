import 'package:langgam_project/models/bidang_layanan_model.dart';
import 'package:langgam_project/models/gambar_model.dart';
import 'package:langgam_project/models/konten_model.dart';

class Layanan {
  List<LayananData>? data;
  Meta? meta;

  Layanan({this.data, this.meta});

  Layanan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LayananData>[];
      json['data'].forEach((v) {
        data!.add(new LayananData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class LayananData {
  int? id;
  LayananAttributes? attributes;

  LayananData({this.id, this.attributes});

  LayananData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new LayananAttributes.fromJson(json['attributes'])
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

class LayananAttributes {
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

  LayananAttributes({
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

  LayananAttributes.fromJson(Map<String, dynamic> json) {
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

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    return data;
  }
}
