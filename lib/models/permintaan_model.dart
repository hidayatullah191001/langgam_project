class PermintaanModel {
  Data? data;

  PermintaanModel({this.data});

  PermintaanModel.fromJson(Map<String, dynamic> json) {
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
      this.nomorPermintaan});

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
    return data;
  }
}
