part of 'services.dart';

class LayananServices {
  static Future<List<Layanan>> getAllLayanans(
      {bool filter = false, String? slugBidangLayanan}) async {
    // String token = await AppSession.getToken();
    Map? responseBody = {};
    String filters = "\$eq";

    if (filter == false) {
      responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans?populate=gambar',
      );
    } else {
      if (slugBidangLayanan != null) {
        responseBody = await APIRequest.gets(
          '${Constant.apirest}/layanans?populate=gambar&filters[bidang_layanan][slug][$filters]=$slugBidangLayanan',
        );
      }
    }

    if (responseBody == null) return [];

    if (responseBody['data'] != null) {
      return List<Layanan>.from(
          responseBody['data'].map((json) => Layanan.fromJson(json))).toList();
    } else {
      throw Exception();
    }
  }

  static Future<Layanan> getLayananById(String id) async {
    try {
      Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/layanans/$id?populate=*',
      );
      if (responseBody!['data'] != null) {
        return Layanan.fromJson(responseBody['data']);
      } else {
        throw "Error Get Data";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<BidangLayanan>> getAllBidangLayanans() async {
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
}
