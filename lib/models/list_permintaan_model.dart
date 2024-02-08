import 'package:langgam_project/models/layanan_model.dart';

class ListPermintaanModel {
  List<Data>? data;
  Meta? meta;

  ListPermintaanModel({this.data, this.meta});

  ListPermintaanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
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
  BillingPembayaran? buktiPembayaran;
  BillingPembayaran? dokumenPermintaan;
  List<Metadata>? metadata;
  List<Komentar>? komentar;
  CustomerUser? customerUser;
  BillingPembayaran? operatorUser;
  Layanan? layanan;

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
        ? new SuratPermintaan.fromJson(json['surat_permintaan'])
        : null;
    billingPembayaran = json['billing_pembayaran'] != null
        ? new BillingPembayaran.fromJson(json['billing_pembayaran'])
        : null;
    buktiPembayaran = json['bukti_pembayaran'] != null
        ? new BillingPembayaran.fromJson(json['bukti_pembayaran'])
        : null;
    dokumenPermintaan = json['dokumen_permintaan'] != null
        ? new BillingPembayaran.fromJson(json['dokumen_permintaan'])
        : null;
    if (json['metadata'] != null) {
      metadata = <Metadata>[];
      json['metadata'].forEach((v) {
        metadata!.add(new Metadata.fromJson(v));
      });
    }
    if (json['komentar'] != null) {
      komentar = <Komentar>[];
      json['komentar'].forEach((v) {
        komentar!.add(new Komentar.fromJson(v));
      });
    }
    customerUser = json['customer_user'] != null
        ? new CustomerUser.fromJson(json['customer_user'])
        : null;
    operatorUser = json['operator_user'] != null
        ? new BillingPembayaran.fromJson(json['operator_user'])
        : null;
    layanan = json['layanan'] != null
        ? new Layanan.fromJson(json['layanan']['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['telepon'] = this.telepon;
    data['perusahaan'] = this.perusahaan;
    data['alamat'] = this.alamat;
    data['kecamatan'] = this.kecamatan;
    data['kota'] = this.kota;
    data['provinsi'] = this.provinsi;
    data['status'] = this.status;
    data['kuantitas'] = this.kuantitas;
    data['komersial'] = this.komersial;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['harga'] = this.harga;
    data['total'] = this.total;
    data['kode_billing'] = this.kodeBilling;
    data['nomor_permintaan'] = this.nomorPermintaan;
    if (this.suratPermintaan != null) {
      data['surat_permintaan'] = this.suratPermintaan!.toJson();
    }
    if (this.billingPembayaran != null) {
      data['billing_pembayaran'] = this.billingPembayaran!.toJson();
    }
    if (this.buktiPembayaran != null) {
      data['bukti_pembayaran'] = this.buktiPembayaran!.toJson();
    }
    if (this.dokumenPermintaan != null) {
      data['dokumen_permintaan'] = this.dokumenPermintaan!.toJson();
    }
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.map((v) => v.toJson()).toList();
    }
    if (this.komentar != null) {
      data['komentar'] = this.komentar!.map((v) => v.toJson()).toList();
    }
    if (this.customerUser != null) {
      data['customer_user'] = this.customerUser!.toJson();
    }
    if (this.operatorUser != null) {
      data['operator_user'] = this.operatorUser!.toJson();
    }
    if (this.layanan != null) {
      data['layanan'] = this.layanan!.toJson();
    }
    return data;
  }
}

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
  Attributes? attributes;

  SuratPermintaanData({this.id, this.attributes});

  SuratPermintaanData.fromJson(Map<String, dynamic> json) {
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

class BillingPembayaran {
  Null? data;

  BillingPembayaran({this.data});

  BillingPembayaran.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field'] = this.field;
    data['data'] = this.data;
    return data;
  }
}

class CustomerUser {
  int? id;
  CustomerUserAttributes? attributes;

  CustomerUser({this.id, this.attributes});

  CustomerUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new CustomerUserAttributes.fromJson(json['attributes'])
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

class CustomerUserAttributes {
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;

  CustomerUserAttributes(
      {this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt});

  CustomerUserAttributes.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

class Komentar {
  int? id;
  String? comment;

  Komentar({this.id, this.comment});

  Komentar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    return data;
  }
}
