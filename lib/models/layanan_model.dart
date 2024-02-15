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
        data!.add(LayananData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
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
        ? LayananAttributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
        konten!.add(Konten.fromJson(v));
      });
    }
    harga = json['harga'];
    satuan = json['satuan'];
    gambar = json['gambar'] != null ? Gambar.fromJson(json['gambar']) : null;
    bidangLayanan = json['bidang_layanan'] != null
        ? BidangLayanan.fromJson(json['bidang_layanan']['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['slug'] = slug;
    data['intro'] = intro;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['judul'] = judul;
    if (konten != null) {
      data['konten'] = konten!.map((v) => v.toJson()).toList();
    }
    data['harga'] = harga;
    data['satuan'] = satuan;
    if (gambar != null) {
      data['gambar'] = gambar!.toJson();
    }
    if (bidangLayanan != null) {
      data['bidang_layanan']['data'] = bidangLayanan!.toJson();
    }
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['pageCount'] = pageCount;
    data['total'] = total;
    return data;
  }
}
