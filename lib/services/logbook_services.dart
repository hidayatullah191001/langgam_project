part of 'services.dart';

class LogbookService {
  static Future<LogbookModel> getAllLogbookAdmin({int? page}) async {
    Map user = await AppSession.getUserInformation();
    String token = user['token'];
    String idUser = user['id'];

    String filters = "\$eq";

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/logbook-harians?populate=*&filters[petugas][id][$filters]=$idUser&pagination[page]=$page&sort[0]=createdAt:desc',
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

  static Future<LogbookModel> getAllLogbookByDate(
      {String? startDate, String? finishDate, int? pageSize}) async {
    final String token = await AppSession.getToken();
    // 2024-01-12
    String gte = "\$gte";
    String lte = "\$lte";
    String filters;
    String pagination;

    if (startDate != null) {
      filters = "filters[createdAt][$gte]=$startDate&sort[0]=createdAt:desc";
    } else if (finishDate != null) {
      filters = "filters[createdAt][$lte]=$finishDate&sort[0]=createdAt:desc";
    } else {
      filters =
          "filters[createdAt][$gte]=$startDate&filters[createdAt][$lte]=$finishDate&sort[0]=createdAt:desc";
    }

    if (pageSize != null) {
      pagination = "pagination[pageSize]=$pageSize";
    } else {
      pagination = "";
    }

    Map? responseBody = await APIRequest.gets(
        '${Constant.apirest}/logbook-harians?populate=*&$filters&$pagination',
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (responseBody == null) throw "Data kosong";
    if (responseBody['data'] != null) {
      return LogbookModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw Exception();
    }
  }
}
