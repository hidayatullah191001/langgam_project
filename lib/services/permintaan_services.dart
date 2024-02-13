part of 'services.dart';

class PermintaanService {
  static Future<ListPermintaanModel> getAllPermintaanCustomer() async {
    Map? userLogin = await AppSession.getUserInformation();
    final emailUser = userLogin['email'];
    final token = userLogin['token'];
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/permintaans?populate=*&filters[customer_user][email][$filters]=$emailUser',
    );

    if (responseBody == null) throw "Data kosong";

    if (responseBody['data'] != null) {
      return ListPermintaanModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<ListPermintaanModelAdmin> getAllPermintaan({int? page}) async {
    final String token = await AppSession.getToken();
    String filters = "\$eq";
    Map? responseBody = {};

    if (page != null) {
      responseBody = await APIRequest.gets(
        '${Constant.apirest}/permintaans?populate=*&pagination[page]=$page',
        headers: {'Authorization': 'Bearer $token'},
      );
    } else {
      responseBody = await APIRequest.gets(
        '${Constant.apirest}/permintaans?populate=*',
        headers: {'Authorization': 'Bearer $token'},
      );
    }

    if (responseBody == null) {
      throw "Data kosong";
    } else {
      return ListPermintaanModelAdmin.fromJson(
          responseBody as Map<String, dynamic>);
    }
  }

  static Future<bool> deletePermintaanByAdmin(String idPermintaan) async {
    Map? userLogin = await AppSession.getUserInformation();
    final token = userLogin['token'];

    Map? responseBody = await APIRequest.delete(
      '${Constant.apirest}/permintaans/$idPermintaan',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (responseBody == null) return false;

    if (responseBody['data'] != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updatePermintaan(
      String idPermintaan, Map<String, dynamic> data) async {
    String token = await AppSession.getToken();
    Map? responseUpdatePermintaan = await APIRequest.put(
      '${Constant.apirest}/permintaans/$idPermintaan',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (responseUpdatePermintaan!['data'] == null) return false;

    if (responseUpdatePermintaan['data'] != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ListPermintaanModel> getAllDokumenPermintaanCustomer() async {
    final Map user = await AppSession.getUserInformation();

    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/permintaans?populate=dokumen_permintaan&populate=customer_user&filters[status][$filters]=Selesai&filters[customer_user][id][$filters]=${user['id']}',
      headers: {'Authorization': 'Bearer ${user['token']}'},
    );

    if (responseBody == null) throw "Data kosong";

    if (responseBody['data'] != null) {
      return ListPermintaanModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<ListPermintaanModelAdmin> getAllPermintaanByStatus(
      String status,
      {int? page}) async {
    final String token = await AppSession.getToken();

    String filters = "\$eq";
    Map? responseBody = {};

    if (page != null) {
      responseBody = await APIRequest.gets(
        '${Constant.apirest}/permintaans?populate=*&filters[status][$filters]=$status&pagination[page]=$page',
        headers: {'Authorization': 'Bearer $token'},
      );
    } else {
      responseBody = await APIRequest.gets(
        '${Constant.apirest}/permintaans?populate=*&filters[status][$filters]=$status',
        headers: {'Authorization': 'Bearer $token'},
      );
    }

    if (responseBody == null) throw "Data kosong";
    if (responseBody['data'] != null) {
      return ListPermintaanModelAdmin.fromJson(
          responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<ListPermintaanModelAdmin> getAllPermintaanByKomersial() async {
    final String token = await AppSession.getToken();

    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/permintaans?populate=*&filters[komersial][$filters]=true',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (responseBody == null) throw "Data kosong";

    if (responseBody['data'] != null) {
      return ListPermintaanModelAdmin.fromJson(
          responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<ListPermintaanModelAdmin> getAllNewPermintaan() async {
    final String token = await AppSession.getToken();
    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/permintaans?populate=*&sort[0]=createdAt:desc',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (responseBody == null) {
      throw "Data kosong";
    } else {
      return ListPermintaanModelAdmin.fromJson(
          responseBody as Map<String, dynamic>);
    }
  }

  static Future<ListPermintaanModelAdmin> getAllPermintaanByDate(
      {String? startDate, String? finishDate, int? page}) async {
    final String token = await AppSession.getToken();
    // 2024-01-12
    String gte = "\$gte";
    String lte = "\$lte";
    String filters;
    String pagination;

    if (startDate != null) {
      filters = "filters[createdAt][$gte]=$startDate";
    } else if (finishDate != null) {
      filters = "filters[createdAt][$lte]=$finishDate";
    } else {
      filters =
          "filters[createdAt][$gte]=$startDate&filters[createdAt][$lte]=$finishDate";
    }

    if (page != null) {
      pagination = "pagination[page]=$page";
    } else {
      pagination = "";
    }

    Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/permintaans?populate=*&$filters&$pagination',
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (responseBody == null) throw "Data kosong";
    if (responseBody['data'] != null) {
      return ListPermintaanModelAdmin.fromJson(
          responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }
}
