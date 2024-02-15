import 'package:langgam_project/models/billing_pembayaran_model.dart';
import 'package:langgam_project/models/bukti_pembayaran_model.dart';
import 'package:langgam_project/models/customer_user_model.dart';
import 'package:langgam_project/models/dokumen_permintaan.dart';
import 'package:langgam_project/models/layanan_model.dart';
import 'package:langgam_project/models/operator_user_model.dart';
import 'package:langgam_project/models/surat_permintaan_model.dart';

class ListPermintaanModel {
  List<Data>? data;
  Meta? meta;

  ListPermintaanModel({this.data, this.meta});

  ListPermintaanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
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

class Attributes {
  String? nama;
  String? email;
  String? telepon;
  String? perusahaan;
  String? alamat;
  String? kecamatan;
  String? kota;
  String? provinsi;
  String? status;
  int? kuantitas;
  bool? komersial;
  String? createdAt;
  String? updatedAt;
  int? harga;
  int? total;
  String? kodeBilling;
  String? nomorPermintaan;
  SuratPermintaan? suratPermintaan;
  BillingPembayaran? billingPembayaran;
  BuktiPembayaran? buktiPembayaran;
  DokumenPermintaan? dokumenPermintaan;
  List<Metadata>? metadata;
  List<Komentar>? komentar;
  CustomerUser? customerUser;
  OperatorUser? operatorUser;
  LayananData? layanan;

  Attributes(
      {this.nama,
      this.email,
      this.telepon,
      this.perusahaan,
      this.alamat,
      this.kecamatan,
      this.kota,
      this.provinsi,
      this.status,
      this.kuantitas,
      this.komersial,
      this.createdAt,
      this.updatedAt,
      this.harga,
      this.total,
      this.kodeBilling,
      this.nomorPermintaan,
      this.suratPermintaan,
      this.billingPembayaran,
      this.buktiPembayaran,
      this.dokumenPermintaan,
      this.metadata,
      this.komentar,
      this.customerUser,
      this.operatorUser,
      this.layanan});

  Attributes.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    email = json['email'];
    telepon = json['telepon'];
    perusahaan = json['perusahaan'];
    alamat = json['alamat'];
    kecamatan = json['kecamatan'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    status = json['status'];
    kuantitas = json['kuantitas'];
    komersial = json['komersial'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    harga = json['harga'];
    total = json['total'];
    kodeBilling = json['kode_billing'];
    nomorPermintaan = json['nomor_permintaan'];
    suratPermintaan = json['surat_permintaan'] != null
        ? SuratPermintaan.fromJson(json['surat_permintaan'])
        : null;
    billingPembayaran = json['billing_pembayaran'] != null
        ? BillingPembayaran.fromJson(json['billing_pembayaran'])
        : null;
    buktiPembayaran = json['bukti_pembayaran'] != null
        ? BuktiPembayaran.fromJson(json['bukti_pembayaran'])
        : null;
    dokumenPermintaan = json['dokumen_permintaan'] != null
        ? DokumenPermintaan.fromJson(json['dokumen_permintaan'])
        : null;
    if (json['metadata'] != null) {
      metadata = <Metadata>[];
      json['metadata'].forEach((v) {
        metadata!.add(Metadata.fromJson(v));
      });
    }
    if (json['komentar'] != null) {
      komentar = <Komentar>[];
      json['komentar'].forEach((v) {
        komentar!.add(Komentar.fromJson(v));
      });
    }
    customerUser = json['customer_user'] != null
        ? CustomerUser.fromJson(json['customer_user'])
        : null;
    operatorUser = json['operator_user'] != null
        ? OperatorUser.fromJson(json['operator_user'])
        : null;
    layanan = json['layanan'] != null
        ? LayananData.fromJson(json['layanan']['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['email'] = email;
    data['telepon'] = telepon;
    data['perusahaan'] = perusahaan;
    data['alamat'] = alamat;
    data['kecamatan'] = kecamatan;
    data['kota'] = kota;
    data['provinsi'] = provinsi;
    data['status'] = status;
    data['kuantitas'] = kuantitas;
    data['komersial'] = komersial;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['harga'] = harga;
    data['total'] = total;
    data['kode_billing'] = kodeBilling;
    data['nomor_permintaan'] = nomorPermintaan;
    if (suratPermintaan != null) {
      data['surat_permintaan'] = suratPermintaan!.toJson();
    }
    if (billingPembayaran != null) {
      data['billing_pembayaran'] = billingPembayaran!.toJson();
    }
    if (buktiPembayaran != null) {
      data['bukti_pembayaran'] = buktiPembayaran!.toJson();
    }
    if (dokumenPermintaan != null) {
      data['dokumen_permintaan'] = dokumenPermintaan!.toJson();
    }
    if (metadata != null) {
      data['metadata'] = metadata!.map((v) => v.toJson()).toList();
    }
    if (komentar != null) {
      data['komentar'] = komentar!.map((v) => v.toJson()).toList();
    }
    if (customerUser != null) {
      data['customer_user'] = customerUser!.toJson();
    }
    if (operatorUser != null) {
      data['operator_user'] = operatorUser!.toJson();
    }
    if (layanan != null) {
      data['layanan'] = layanan!.toJson();
    }
    return data;
  }
}

class Metadata {
  int? id;
  String? field;
  String? data;

  Metadata({this.id, this.field, this.data});

  Metadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field'] = field;
    data['data'] = data;
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

class Komentar {
  int? id;
  String? comment;

  Komentar({this.id, this.comment});

  Komentar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    return data;
  }
}
