class PermintaanFormModel {
  Data? data;

  PermintaanFormModel({this.data});

  PermintaanFormModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? nama;
  String? email;
  String? telepon;
  String? perusahaan;
  String? alamat;
  String? kecamatan;
  String? kota;
  String? provinsi;
  String? status;
  bool? komersial;
  List<Metadata>? metadata;
  String? customerUser;
  String? layanan;
  int? harga;
  int? kuantitas;
  int? total;
  String? nomorPermintaan;

  Data(
      {this.nama,
      this.email,
      this.telepon,
      this.perusahaan,
      this.alamat,
      this.kecamatan,
      this.kota,
      this.provinsi,
      this.status,
      this.komersial,
      this.metadata,
      this.customerUser,
      this.layanan,
      this.harga,
      this.kuantitas,
      this.total,
      this.nomorPermintaan});

  Data.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    email = json['email'];
    telepon = json['telepon'];
    perusahaan = json['perusahaan'];
    alamat = json['alamat'];
    kecamatan = json['kecamatan'];
    kota = json['kota'];
    provinsi = json['provinsi'];
    status = json['status'];
    komersial = json['komersial'];
    if (json['metadata'] != null) {
      metadata = <Metadata>[];
      json['metadata'].forEach((v) {
        metadata!.add(new Metadata.fromJson(v));
      });
    }
    customerUser = json['customer_user'];
    layanan = json['layanan'];
    harga = json['harga'];
    kuantitas = json['kuantitas'];
    total = json['total'];
    nomorPermintaan = json['nomor_permintaan'];
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
    data['komersial'] = this.komersial;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.map((v) => v.toJson()).toList();
    }
    data['customer_user'] = this.customerUser;
    data['layanan'] = this.layanan;
    data['harga'] = this.harga;
    data['kuantitas'] = this.kuantitas;
    data['total'] = this.total;
    data['nomor_permintaan'] = this.nomorPermintaan;
    return data;
  }
}

class Metadata {
  String? field;
  String? data;

  Metadata({this.field, this.data});

  Metadata.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['data'] = this.data;
    return data;
  }
}
