part of 'services.dart';

class BantuanService {
  static Future<BantuanModel> getAllBantuan() async {
    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/bantuans?populate=*',
    );

    if (responseBody == null) throw "Data Null";

    if (responseBody['data'] != null) {
      return BantuanModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<BantuanModel> getBantuanBySlug(String slug) async {
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/bantuans?populate=*&filters[slug][$filters]=$slug',
    );

    if (responseBody == null) throw "Data Null";

    if (responseBody['data'] != null) {
      return BantuanModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }
}
