part of 'services.dart';

class WilayahServices {
  static Future<List<Provinsi>> getAllProvinsis() async {
    // String token = await AppSession.getToken();
    try {
      Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/data-provinsis?pagination[pageSize]=34',
      );
      if (responseBody == null) {
        return [];
      } else {
        return List<Provinsi>.from(
                responseBody['data'].map((json) => Provinsi.fromJson(json)))
            .toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Kota>> getAllKotas(String? namaProvinsi) async {
    // String token = await AppSession.getToken();
    String filters = "\$eq";
    try {
      Map? responseBody = await APIRequest.gets(
        "${Constant.apirest}/data-kotas?pagination[pageSize]=100&filters[nama_provinsi][$filters]=$namaProvinsi",
      );
      if (responseBody == null) {
        return [];
      } else {
        return List<Kota>.from(
            responseBody['data'].map((json) => Kota.fromJson(json))).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Kecamatan>> getAllKecamatan(String? namaKota) async {
    // String token = await AppSession.getToken();
    String filters = "\$eq";
    try {
      Map? responseBody = await APIRequest.gets(
        "${Constant.apirest}/data-kecamatans?pagination[pageSize]=100&filters[nama_kota][$filters]=$namaKota",
      );
      if (responseBody == null) {
        return [];
      } else {
        return List<Kecamatan>.from(
                responseBody['data'].map((json) => Kecamatan.fromJson(json)))
            .toList();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
