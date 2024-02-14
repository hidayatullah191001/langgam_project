import 'package:langgam_project/models/petugas_model.dart';

class LogbookModel {
  List<LogbookData>? data;
  Meta? meta;

  LogbookModel({this.data, this.meta});

  LogbookModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LogbookData>[];
      json['data'].forEach((v) {
        data!.add(new LogbookData.fromJson(v));
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

class LogbookData {
  int? id;
  LogbookAttributes? attributes;

  LogbookData({this.id, this.attributes});

  LogbookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new LogbookAttributes.fromJson(json['attributes'])
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

class LogbookAttributes {
  String? perihalPermohonan;
  String? namaPemohon;
  String? nomorTelepon;
  String? waktuPengerjaan;
  int? pembayaran;
  String? status;
  String? waktuPengambilan;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  Petugas? petugas;

  LogbookAttributes(
      {this.perihalPermohonan,
      this.namaPemohon,
      this.nomorTelepon,
      this.waktuPengerjaan,
      this.pembayaran,
      this.status,
      this.waktuPengambilan,
      this.keterangan,
      this.createdAt,
      this.updatedAt,
      this.petugas});

  LogbookAttributes.fromJson(Map<String, dynamic> json) {
    perihalPermohonan = json['perihal_permohonan'];
    namaPemohon = json['nama_pemohon'];
    nomorTelepon = json['nomor_telepon'];
    waktuPengerjaan = json['waktu_pengerjaan'];
    pembayaran = json['pembayaran'];
    status = json['status'];
    waktuPengambilan = json['waktu_pengambilan'];
    keterangan = json['keterangan'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    petugas =
        json['petugas'] != null ? new Petugas.fromJson(json['petugas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perihal_permohonan'] = this.perihalPermohonan;
    data['nama_pemohon'] = this.namaPemohon;
    data['nomor_telepon'] = this.nomorTelepon;
    data['waktu_pengerjaan'] = this.waktuPengerjaan;
    data['pembayaran'] = this.pembayaran;
    data['status'] = this.status;
    data['waktu_pengambilan'] = this.waktuPengambilan;
    data['keterangan'] = this.keterangan;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.petugas != null) {
      data['petugas'] = this.petugas!.toJson();
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
