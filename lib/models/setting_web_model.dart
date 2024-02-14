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
  // SettingWebModel? homepageJumbotronVideoThumb;
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
      // this.homepageJumbotronVideoThumb,
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
    // homepageJumbotronVideoThumb = json['homepage_jumbotron_video_thumb'] != null
    //     ? new SettingWebModel.fromJson(json['homepage_jumbotron_video_thumb'])
    //     : null;
    if (json['sosmed'] != null) {
      sosmed = <Sosmed>[];
      json['sosmed'].forEach((v) {
        sosmed!.add(new Sosmed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['homepage_jumbotron_video_url'] = this.homepageJumbotronVideoUrl;
    data['homepage_jumbotron_judul_utama'] = this.homepageJumbotronJudulUtama;
    data['homepage_jumbotron_intro'] = this.homepageJumbotronIntro;
    data['homepage_jumbotron_tombol_teks'] = this.homepageJumbotronTombolTeks;
    data['homepage_jumbotron_tombol_url'] = this.homepageJumbotronTombolUrl;
    data['homepage_layanan_judul_utama'] = this.homepageLayananJudulUtama;
    data['homepage_layanan_intro'] = this.homepageLayananIntro;
    data['homepage_layanan_tombol_teks'] = this.homepageLayananTombolTeks;
    data['homepage_layanan_tombol_url'] = this.homepageLayananTombolUrl;
    data['footer_alamat'] = this.footerAlamat;
    data['footer_telepon'] = this.footerTelepon;
    data['footer_email'] = this.footerEmail;
    data['footer_credit'] = this.footerCredit;
    // if (this.homepageJumbotronVideoThumb != null) {
    //   data['homepage_jumbotron_video_thumb'] =
    //       this.homepageJumbotronVideoThumb!.toJson();
    // }
    if (this.sosmed != null) {
      data['sosmed'] = this.sosmed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class SettingWebData {
//   int? id;
//   SettingWebAttributes? attributes;

//   SettingWebData({this.id, this.attributes});

//   SettingWebData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     attributes = json['attributes'] != null
//         ? new SettingWebAttributes.fromJson(json['attributes'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.attributes != null) {
//       data['attributes'] = this.attributes!.toJson();
//     }
//     return data;
//   }
// }

// class Attributes {
//   String? name;
//   Null? alternativeText;
//   Null? caption;
//   Null? width;
//   Null? height;
//   Null? formats;
//   String? hash;
//   String? ext;
//   String? mime;
//   double? size;
//   String? url;
//   Null? previewUrl;
//   String? provider;
//   Null? providerMetadata;
//   String? createdAt;
//   String? updatedAt;

//   Attributes(
//       {this.name,
//       this.alternativeText,
//       this.caption,
//       this.width,
//       this.height,
//       this.formats,
//       this.hash,
//       this.ext,
//       this.mime,
//       this.size,
//       this.url,
//       this.previewUrl,
//       this.provider,
//       this.providerMetadata,
//       this.createdAt,
//       this.updatedAt});

//   Attributes.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     alternativeText = json['alternativeText'];
//     caption = json['caption'];
//     width = json['width'];
//     height = json['height'];
//     formats = json['formats'];
//     hash = json['hash'];
//     ext = json['ext'];
//     mime = json['mime'];
//     size = json['size'];
//     url = json['url'];
//     previewUrl = json['previewUrl'];
//     provider = json['provider'];
//     providerMetadata = json['provider_metadata'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['alternativeText'] = this.alternativeText;
//     data['caption'] = this.caption;
//     data['width'] = this.width;
//     data['height'] = this.height;
//     data['formats'] = this.formats;
//     data['hash'] = this.hash;
//     data['ext'] = this.ext;
//     data['mime'] = this.mime;
//     data['size'] = this.size;
//     data['url'] = this.url;
//     data['previewUrl'] = this.previewUrl;
//     data['provider'] = this.provider;
//     data['provider_metadata'] = this.providerMetadata;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
