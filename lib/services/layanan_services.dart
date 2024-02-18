part of 'services.dart';

class LayananServices {
  static Future<Layanan> getAllLayanans(
      {bool filter = false, String? slugBidangLayanan, int? page}) async {
    // String token = await AppSession.getToken();
    Map? responseBody = {};
    String filters = "\$eq";

    if (filter == false) {
      responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans?populate=*&pagination[page]=$page&sort[0]=createdAt:desc',
      );
    } else {
      if (slugBidangLayanan != null) {
        responseBody = await APIRequest.gets(
          '${Constant.apirest}/layanans?populate=gambar&filters[bidang_layanan][slug][$filters]=$slugBidangLayanan&pagination[page]=$page&sort[0]=createdAt:desc',
        );
      }
    }

    if (responseBody == null) throw "Data Kosong";

    if (responseBody['data'] != null) {
      // return List<Layanan>.from(
      //     responseBody['data'].map((json) => Layanan.fromJson(json))).toList();
      return Layanan.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<Layanan> getLayananById(String id) async {
    try {
      Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans/$id?populate=*&sort[0]=createdAt:desc',
      );
      if (responseBody!['data'] != null) {
        return Layanan.fromJson(responseBody as Map<String, dynamic>);
      } else {
        throw "Error Get Data";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Layanan> getLayananBySlug(String slug) async {
    try {
      String filters = "\$eq";
      Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans?populate=*&filters[slug][$filters]=$slug&sort[0]=createdAt:desc',
      );
      if (responseBody!['data'] != null) {
        return Layanan.fromJson(responseBody as Map<String, dynamic>);
      } else {
        throw "Error Get Data";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Layanan> getLayananByBidangLayananId(String id) async {
    try {
      String filters = "\$eq";
      Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans?populate=*&filters[bidang_layanan][id][$filters]=$id',
      );
      if (responseBody!['data'] != null) {
        // return List<Layanan>.from(
        //         responseBody['data'].map((json) => Layanan.fromJson(json)))
        //     .toList();
        return Layanan.fromJson(responseBody as Map<String, dynamic>);
      } else {
        return throw "Data kosong";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Layanan> getLayananByValue(String value) async {
    try {
      String filters = "\$contains";
      Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans?populate=*&filters[judul][$filters]=$value&sort[0]=createdAt:desc',
      );
      if (responseBody!['data'] != null) {
        return Layanan.fromJson(responseBody as Map<String, dynamic>);
      } else {
        return throw "Data kosong";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<BidangLayanan>> getAllBidangLayanans({int? page}) async {
    // String token = await AppSession.getToken();
    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/bidang-layanans?populate=*',
    );
    if (responseBody == null) return [];

    if (responseBody['data'] != null) {
      return List<BidangLayanan>.from(
              responseBody['data'].map((json) => BidangLayanan.fromJson(json)))
          .toList();
    } else {
      throw Exception();
    }
  }

  static Future<BidangLayanan> getBidangLayananById(int? id) async {
    // String token = await AppSession.getToken();
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/bidang-layanans/$id?populate=*',
    );

    if (responseBody == null) return throw 'Error';

    if (responseBody['data'] != null) {
      return BidangLayanan.fromJson(responseBody['data']);
    } else {
      throw Exception();
    }
  }

  static Future<BidangLayanan> getBidangLayananBySlug(String slug) async {
    // String token = await AppSession.getToken();
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/bidang-layanans?filters[slug][$filters]=$slug',
    );
    if (responseBody == null) return throw 'Error';

    if (responseBody['data'] != null) {
      return BidangLayanan.fromJson(responseBody['data'][0]);
    } else {
      throw Exception();
    }
  }
}
