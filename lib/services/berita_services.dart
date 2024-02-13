part of 'services.dart';

class BeritaService {
  static Future<BeritaModel> getAllBerita() async {
    // String token = await AppSession.getToken();
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/posts?populate=*',
    );

    if (responseBody == null) throw "Data Null";

    if (responseBody['data'] != null) {
      return BeritaModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<BeritaModel> getBeritaBySlug(String slug) async {
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/posts?populate=*&filters[slug][$filters]=$slug',
    );

    if (responseBody == null) throw "Data Null";

    if (responseBody['data'] != null) {
      return BeritaModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }
}
