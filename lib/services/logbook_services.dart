part of 'services.dart';

class LogbookService {
  static Future<LogbookModel> getAllLogbookAdmin({int? page}) async {
    Map user = await AppSession.getUserInformation();
    String token = user['token'];
    String idUser = user['id'];

    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/logbook-harians?populate=*&filters[petugas][id][$filters]=$idUser&pagination[page]=$page',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (responseBody == null) throw 'Data Kosong';

    if (responseBody['data'] != null) {
      return LogbookModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }

  static Future<Map<String, dynamic>> createLogbook(
      LogbookFormModel data) async {
    String token = await AppSession.getToken();

    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/logbook-harians',
      body: json.encode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (responseBody!['data'] == null) {
      return {
        'success': false,
        'error': responseBody['error']['message'],
      };
    }
    if (responseBody['data'].isNotEmpty) {
      return {'success': true, 'data': responseBody};
    } else {
      return {
        'success': false,
        'error': 'Something went wrong',
      };
    }
  }

  static Future<Map<String, dynamic>> updateLogbook(
      LogbookFormModel data, String id) async {
    String token = await AppSession.getToken();

    Map? responseBody = await APIRequest.put(
      '${Constant.apirest}/logbook-harians/$id',
      body: json.encode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (responseBody!['data'] == null) {
      return {
        'success': false,
        'error': responseBody['error']['message'],
      };
    }

    if (responseBody['data'].isNotEmpty) {
      return {'success': true, 'data': responseBody};
    } else {
      return {
        'success': false,
        'error': 'Something went wrong',
      };
    }
  }

  static Future<Map<String, dynamic>> deleteLogbook(String id) async {
    String token = await AppSession.getToken();

    Map? responseBody = await APIRequest.delete(
      '${Constant.apirest}/logbook-harians/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (responseBody!['data'] == null) {
      return {
        'success': false,
        'error': responseBody['error']['message'],
      };
    }

    if (responseBody['data'].isNotEmpty) {
      return {'success': true, 'data': responseBody};
    } else {
      return {
        'success': false,
        'error': 'Something went wrong',
      };
    }
  }
}
