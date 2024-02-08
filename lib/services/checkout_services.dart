part of 'services.dart';

class CheckoutService {
  /* 
    Response UploadFile 
    [      
      {
      "id": 53,
      "name": "citra.png",
      "alternativeText": null,
      "caption": null,
      "width": 998,
      "height": 555,
      "formats": {
      "small": {
      "ext": ".png",
      "url": "/uploads/small_citra_a8212c4f99.png",
      "hash": "small_citra_a8212c4f99",
      "mime": "image/png",
      "name": "small_citra.png",
      "path": null,
      "size": 95.59,
      "width": 500,
      "height": 278
      },
      "medium": {
      "ext": ".png",
      "url": "/uploads/medium_citra_a8212c4f99.png",
      "hash": "medium_citra_a8212c4f99",
      "mime": "image/png",
      "name": "medium_citra.png",
      "path": null,
      "size": 175.92,
      "width": 750,
      "height": 417
      },
      "thumbnail": {
      "ext": ".png",
      "url": "/uploads/thumbnail_citra_a8212c4f99.png",
      "hash": "thumbnail_citra_a8212c4f99",
      "mime": "image/png",
      "name": "thumbnail_citra.png",
      "path": null,
      "size": 31.95,
      "width": 245,
      "height": 136
      }
      },
      "hash": "citra_a8212c4f99",
      "ext": ".png",
      "mime": "image/png",
      "size": 51.31,
      "url": "/uploads/citra_a8212c4f99.png",
      "previewUrl": null,
      "provider": "local",
      "provider_metadata": null,
      "createdAt": "2024-01-27T15:12:08.808Z",
      "updatedAt": "2024-01-27T15:12:08.808Z"
      }

    ]
  */
  static Future<void> uploadFileToApi(
      Uint8List fileBytes, String idLayanan) async {
    String token = await AppSession.getToken();
    // Ganti URL_API dengan URL sesuai dengan API Anda
    final String apiUrl = '${Constant.apirest}/upload';

    // Buat objek http.MultipartRequest untuk membuat permintaan multipart
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    );

    // Tambahkan file ke permintaan multipart
    request.files.add(http.MultipartFile.fromBytes(
      'files',
      fileBytes,
      filename: 'filename.png', // Ganti dengan nama file yang sesuai
    ));

    request.headers['Authorization'] = 'Bearer $token';

    // Tambahkan parameter lain yang diperlukan
    request.fields['ref'] = 'api::permintaan.permintaan”';
    request.fields['refId'] = idLayanan;
    request.fields['field'] = '“surat_permintaan';

    try {
      // Kirim permintaan multipart ke API
      final response = await request.send();

      // Cek apakah permintaan berhasil
      if (response.statusCode == 200) {
        print(response);
        print('File berhasil diupload');
      } else {
        print('Gagal mengupload file. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
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
