class SettingWebModel {
  SettingWebData? data;

  SettingWebModel({this.data});

  SettingWebModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new SettingWebData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SettingWebData {
  int? id;
  SettingWebAttributes? attributes;

  SettingWebData({this.id, this.attributes});

  SettingWebData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new SettingWebAttributes.fromJson(json['attributes'])
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

class SettingWebAttributes {
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? homepageJumbotronVideoUrl;
  String? homepageJumbotronJudulUtama;
  String? homepageJumbotronIntro;
  String? homepageJumbotronTombolTeks;
  String? homepageJumbotronTombolUrl;
  String? homepageLayananJudulUtama;
  String? homepageLayananIntro;
  String? homepageLayananTombolTeks;
  String? homepageLayananTombolUrl;
  String? footerAlamat;
  String? footerTelepon;
  String? footerEmail;
  String? footerCredit;
  List<Sosmed>? sosmed;

  SettingWebAttributes(
      {this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.homepageJumbotronVideoUrl,
      this.homepageJumbotronJudulUtama,
      this.homepageJumbotronIntro,
      this.homepageJumbotronTombolTeks,
      this.homepageJumbotronTombolUrl,
      this.homepageLayananJudulUtama,
      this.homepageLayananIntro,
      this.homepageLayananTombolTeks,
      this.homepageLayananTombolUrl,
      this.footerAlamat,
      this.footerTelepon,
      this.footerEmail,
      this.footerCredit,
      this.sosmed});

  SettingWebAttributes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    homepageJumbotronVideoUrl = json['homepage_jumbotron_video_url'];
    homepageJumbotronJudulUtama = json['homepage_jumbotron_judul_utama'];
    homepageJumbotronIntro = json['homepage_jumbotron_intro'];
    homepageJumbotronTombolTeks = json['homepage_jumbotron_tombol_teks'];
    homepageJumbotronTombolUrl = json['homepage_jumbotron_tombol_url'];
    homepageLayananJudulUtama = json['homepage_layanan_judul_utama'];
    homepageLayananIntro = json['homepage_layanan_intro'];
    homepageLayananTombolTeks = json['homepage_layanan_tombol_teks'];
    homepageLayananTombolUrl = json['homepage_layanan_tombol_url'];
    footerAlamat = json['footer_alamat'];
    footerTelepon = json['footer_telepon'];
    footerEmail = json['footer_email'];
    footerCredit = json['footer_credit'];
    if (json['sosmed'] != null) {
      sosmed = <Sosmed>[];
      json['sosmed'].forEach((v) {
        sosmed!.add(new Sosmed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    data['homepage_jumbotron_video_url'] = homepageJumbotronVideoUrl;
    data['homepage_jumbotron_judul_utama'] = homepageJumbotronJudulUtama;
    data['homepage_jumbotron_intro'] = homepageJumbotronIntro;
    data['homepage_jumbotron_tombol_teks'] = homepageJumbotronTombolTeks;
    data['homepage_jumbotron_tombol_url'] = homepageJumbotronTombolUrl;
    data['homepage_layanan_judul_utama'] = homepageLayananJudulUtama;
    data['homepage_layanan_intro'] = homepageLayananIntro;
    data['homepage_layanan_tombol_teks'] = homepageLayananTombolTeks;
    data['homepage_layanan_tombol_url'] = homepageLayananTombolUrl;
    data['footer_alamat'] = footerAlamat;
    data['footer_telepon'] = footerTelepon;
    data['footer_email'] = footerEmail;
    data['footer_credit'] = footerCredit;
    if (sosmed != null) {
      data['sosmed'] = sosmed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sosmed {
  int? id;
  String? name;
  String? url;

  Sosmed({this.id, this.name, this.url});

  Sosmed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
