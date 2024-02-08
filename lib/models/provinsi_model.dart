class Provinsi {
  int? id;
  Attributes? attributes;

  Provinsi({this.id, this.attributes});

  Provinsi.fromJson(Map<String, dynamic> json) {
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

  String? namaProvinsi;

  Attributes({this.kodeWilayah, this.namaProvinsi});

  Attributes.fromJson(Map<String, dynamic> json) {
    kodeWilayah = json['kode_wilayah'];
    namaProvinsi = json['nama_provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_wilayah'] = this.kodeWilayah;
    data['nama_provinsi'] = this.namaProvinsi;
    return data;
  }
}
