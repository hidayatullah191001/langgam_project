class LogbookFormModel {
  LogbookFormData? data;

  LogbookFormModel({this.data});

  LogbookFormModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new LogbookFormData.fromJson(json['data'])
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

class LogbookFormData {
  String? perihalPermohonan;
  String? namaPemohon;
  String? nomorTelepon;
  String? waktuPengerjaan;
  int? pembayaran;
  String? status;
  String? waktuPengambilan;
  String? keterangan;
  String? petugas;

  LogbookFormData(
      {this.perihalPermohonan,
      this.namaPemohon,
      this.nomorTelepon,
      this.waktuPengerjaan,
      this.pembayaran,
      this.status,
      this.waktuPengambilan,
      this.keterangan,
      this.petugas});

  LogbookFormData.fromJson(Map<String, dynamic> json) {
    perihalPermohonan = json['perihal_permohonan'];
    namaPemohon = json['nama_pemohon'];
    nomorTelepon = json['nomor_telepon'];
    waktuPengerjaan = json['waktu_pengerjaan'];
    pembayaran = json['pembayaran'];
    status = json['status'];
    waktuPengambilan = json['waktu_pengambilan'];
    keterangan = json['keterangan'];
    petugas = json['petugas'];
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
    data['petugas'] = this.petugas;

    return data;
  }
}
