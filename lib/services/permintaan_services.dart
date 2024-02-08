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
}
