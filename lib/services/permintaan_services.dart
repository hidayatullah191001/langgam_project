part of 'services.dart';

class PermintaanService {
  static Future<ListPermintaanModel> getAllPermintaanCustomer() async {
    Map? userLogin = await AppSession.getUserInformation();
    final emailUser = userLogin['email'];
    final token = userLogin['token'];
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/permintaans?populate=*&filters[customer_user][email][$filters]=$emailUser',
        headers: {
          'Authorization': 'Bearer $token',
        });

    if (responseBody == null) throw "Data kosong";

    if (responseBody['data'] != null) {
      // return List<ListPermintaanModel>.from(responseBody['data']
      //     .map((json) => ListPermintaanModel.fromJson(json))).toList();
      return ListPermintaanModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<ListPermintaanModelAdmin> getAllPermintaan() async {
    Map? userLogin = await AppSession.getUserInformation();
    final emailUser = userLogin['email'];
    final token = userLogin['token'];
    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/permintaans?populate=*',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (responseBody == null) throw "Data kosong";

    if (responseBody['data'] != null) {
      return ListPermintaanModelAdmin.fromJson(
          responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
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

  // static Future<ListPermintaanModel> getAllPermintaanCustomerForAdmin() async {
  //   Map? userLogin = await AppSession.getUserInformation();
  //   final token = userLogin['token'];
  //   final emailUser = userLogin['email'];
  //   String filters = "\$eq";

  //   Map? responseBody = await APIRequest.gets(
  //       '${Constant.apirest}/permintaans?populate=*&filters[customer_user][email][$filters]=$emailUser',
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       });
  //   if (responseBody!['data'] != null) {
  //     print(responseBody);
  //     // return List<ListPermintaanModel>.from(responseBody['data']
  //     //     .map((json) => ListPermintaanModel.fromJson(json))).toList();
  //     return ListPermintaanModel.fromJson(json.decode(responseBody.toString()));
  //   } else {
  //     throw Exception();
  //   }
  // }

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
    print(responseUpdatePermintaan!['data']);
    if (responseUpdatePermintaan['data'] == null) return false;

    if (responseUpdatePermintaan['data'] != null) {
      return true;
    } else {
      return false;
    }
  }
}
