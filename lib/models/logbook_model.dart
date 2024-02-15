import 'package:langgam_project/models/petugas_model.dart';

class LogbookModel {
  List<LogbookData>? data;
  Meta? meta;

  LogbookModel({this.data, this.meta});

  LogbookModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LogbookData>[];
      json['data'].forEach((v) {
        data!.add(LogbookData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
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
        ? LogbookAttributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
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
        json['petugas'] != null ? Petugas.fromJson(json['petugas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['perihal_permohonan'] = perihalPermohonan;
    data['nama_pemohon'] = namaPemohon;
    data['nomor_telepon'] = nomorTelepon;
    data['waktu_pengerjaan'] = waktuPengerjaan;
    data['pembayaran'] = pembayaran;
    data['status'] = status;
    data['waktu_pengambilan'] = waktuPengambilan;
    data['keterangan'] = keterangan;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (petugas != null) {
      data['petugas'] = petugas!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['pageCount'] = pageCount;
    data['total'] = total;
    return data;
  }
}
