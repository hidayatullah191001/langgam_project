class Kota {
  int? id;
  Attributes? attributes;

  Kota({this.id, this.attributes});

  Kota.fromJson(Map<String, dynamic> json) {
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
  String? kodeWilayah;
  String? namaKota;
  String? namaProvinsi;

  Attributes({this.kodeWilayah, this.namaKota, this.namaProvinsi});

  Attributes.fromJson(Map<String, dynamic> json) {
    kodeWilayah = json['kode_wilayah'];
    namaKota = json['nama_kota'];
    namaProvinsi = json['nama_provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_wilayah'] = this.kodeWilayah;
    data['nama_kota'] = this.namaKota;
    data['nama_provinsi'] = this.namaProvinsi;
    return data;
  }
}
