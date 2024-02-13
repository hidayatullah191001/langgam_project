part of 'services.dart';

class CheckoutService {
  static Future<Map<String, dynamic>> uploadFile(
      Uint8List? file, String fileName, String idLayanan, String field) async {
    String token = await AppSession.getToken();

    var requestUrl = Uri.parse('${Constant.apirest}/upload');
    var request = http.MultipartRequest('POST', requestUrl);
    request.fields['ref'] = 'api::permintaan.permintaan';
    request.fields['refId'] = idLayanan;
    request.fields['field'] = field;
    request.headers['Authorization'] = 'Bearer $token';

    Uint8List uint8list = Uint8List.fromList(file!);

    // Tambahkan file ke dalam request
    request.files.add(http.MultipartFile.fromBytes(
      'files',
      uint8list,
      filename: fileName, // gunakan nama file dari properti name
    ));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      List<dynamic> responseData = jsonDecode(response.body);
      int idFileUpload = responseData[0]['id'];
      return {
        'success': true,
        'idFileUpload': idFileUpload,
      };
    } catch (e) {
      return {
        'success': false,
      };
    }
  }

  static Future<Map<String, dynamic>> createPermintaanUser(
      PermintaanFormModel model) async {
    String token = await AppSession.getToken();

    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/permintaans',
      body: json.encode(model.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (responseBody!['data'] == null)
      return {
        'success': false,
        'error': 'Something went wrong',
      };

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
