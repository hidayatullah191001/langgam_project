import 'package:langgam_project/models/gambar_model.dart';
import 'package:langgam_project/models/konten_model.dart';

class BantuanModel {
  List<BantuanData>? data;
  Meta? meta;

  BantuanModel({this.data, this.meta});

  BantuanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BantuanData>[];
      json['data'].forEach((v) {
        data!.add(new BantuanData.fromJson(v));
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

class BantuanData {
  int? id;
  BantuanAttributes? attributes;

  BantuanData({this.id, this.attributes});

  BantuanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new BantuanAttributes.fromJson(json['attributes'])
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

class BantuanAttributes {
  String? judul;
  String? slug;
  String? intro;
  List<Konten>? konten;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  Gambar? gambar;

  BantuanAttributes(
      {this.judul,
      this.slug,
      this.intro,
      this.konten,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.gambar});

  BantuanAttributes.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    slug = json['slug'];
    intro = json['intro'];
    if (json['konten'] != null) {
      konten = <Konten>[];
      json['konten'].forEach((v) {
        konten!.add(new Konten.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    gambar =
        json['gambar'] != null ? new Gambar.fromJson(json['gambar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['slug'] = this.slug;
    data['intro'] = this.intro;
    if (this.konten != null) {
      data['konten'] = this.konten!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    if (this.gambar != null) {
      data['gambar'] = this.gambar!.toJson();
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
