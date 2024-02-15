class Kota {
  int? id;
  Attributes? attributes;

  Kota({id, attributes});

  Kota.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? kodeWilayah;
  String? namaKota;
  String? namaProvinsi;

  Attributes({kodeWilayah, namaKota, namaProvinsi});

  Attributes.fromJson(Map<String, dynamic> json) {
    kodeWilayah = json['kode_wilayah'];
    namaKota = json['nama_kota'];
    namaProvinsi = json['nama_provinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_wilayah'] = kodeWilayah;
    data['nama_kota'] = namaKota;
    data['nama_provinsi'] = namaProvinsi;
    return data;
  }
}
