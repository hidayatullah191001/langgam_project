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

  // static Future<void> uploadFile(File file, String idLayanan) async {
  //   // URL endpoint untuk upload file
  //   var url = Uri.parse('YOUR_UPLOAD_ENDPOINT_URL');

  //   // Buat request multipart
  //   var request = http.MultipartRequest('POST', url);

  //   // Tambahkan file ke request
  //   request.files.add(await http.MultipartFile.fromPath(
  //     'files', // Nama field untuk file
  //     file.path, // Path file yang akan diupload
  //   ));

  //   // Tambahkan parameter lain ke request
  //   request.fields['ref'] = 'api::permintaan.permintaan';
  //   request.fields['refId'] = idLayanan; // ID entry layanan
  //   request.fields['field'] = 'surat_permintaan';

  //   // Kirim request
  //   var response = await request.send();

  //   // Cek kode status response
  //   if (response.statusCode == 200) {
  //     print('File berhasil diupload');
  //   } else {
  //     print('Gagal mengupload file. Kode status: ${response.statusCode}');
  //   }
  // }

  // static Future<void> uploadFileToApi(
  //     Uint8List fileBytes, String idLayanan) async {
  //   String token = await AppSession.getToken();
  //   // Ganti URL_API dengan URL sesuai dengan API Anda
  //   final String apiUrl = '${Constant.apirest}/upload';

  //   // Buat objek http.MultipartRequest untuk membuat permintaan multipart
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(apiUrl),
  //   );

  //   // Tambahkan file ke permintaan multipart
  //   request.files.add(http.MultipartFile.fromBytes(
  //     'files',
  //     fileBytes,
  //     filename: 'filename.png', // Ganti dengan nama file yang sesuai
  //   ));

  //   request.headers['Authorization'] = 'Bearer $token';

  //   // Tambahkan parameter lain yang diperlukan
  //   request.fields['ref'] = 'api::permintaan.permintaan';
  //   request.fields['refId'] = idLayanan;
  //   request.fields['field'] = 'surat_permintaan';

  //   try {
  //     // Kirim permintaan multipart ke API
  //     final response = await request.send();

  //     // Cek apakah permintaan berhasil
  //     if (response.statusCode == 200) {
  //       print(idLayanan);
  //       print(response.stream);
  //       print('File berhasil diupload');
  //     } else {
  //       print('Gagal mengupload file. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Terjadi kesalahan: $error');
  //   }
  // }

  // static Future<void> uploadFile(File file, String idLayanan) async {
  //   var requestUrl =
  //       Uri.parse('${Constant.apirest}/upload'); // Ganti dengan URL API Anda
  //   var request = http.MultipartRequest('POST', requestUrl);
  //   request.fields['ref'] = 'api::permintaan.permintaan';
  //   request.fields['refId'] = idLayanan;
  //   request.fields['field'] = 'surat_permintaan';
  //   request.files.add(http.MultipartFile(
  //     'files',
  //     file.readAsBytes().asStream(),
  //     file.lengthSync(),
  //     filename: file.path.split('/').last,
  //   ));

  //   try {
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       print('File Uploaded Successfully');
  //     } else {
  //       print('Failed to upload file: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //   }
  // }

  // static Future<bool> uploadFile(html.File file, String idLayanan) async {
  //   String token = await AppSession.getToken();

  //   var requestUrl = Uri.parse('${Constant.apirest}/upload');
  //   var request = http.MultipartRequest('POST', requestUrl);
  //   request.fields['ref'] = 'api::permintaan.permintaan';
  //   request.fields['refId'] = idLayanan;
  //   request.fields['field'] = 'surat_permintaan';
  //   request.headers['Authorization'] = 'Bearer $token';

  //   // Buat FileReader untuk membaca konten file sebagai array byte
  //   var reader = html.FileReader();
  //   reader.readAsArrayBuffer(file);
  //   await reader.onLoad.first; // Tunggu hingga pembacaan selesai
  //   Uint8List uint8list = Uint8List.fromList(reader.result as List<int>);

  //   // Tambahkan file ke dalam request
  //   request.files.add(http.MultipartFile.fromBytes(
  //     'files',
  //     uint8list,
  //     filename: file.name, // gunakan nama file dari properti name
  //   ));

  //   try {
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     List<dynamic> responseData = jsonDecode(response.body);

  //     int? id = responseData[0]['id'];
  //     print(responseData);
  //     print(id);
  //     if (response.statusCode == 200) {
  //       Map? responseUpdatePermintaan = await APIRequest.put(
  //         '${Constant.apirest}/permintaans/$idLayanan',
  //         body: json.encode({
  //           "data": {
  //             "surat_permintaan": id.toString(),
  //           }
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       );

  //       print(responseUpdatePermintaan);

  //       if (responseUpdatePermintaan!['data'] == null) return false;

  //       if (responseUpdatePermintaan['data'] != null) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //     return false;
  //   }
  // }

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
      print('response $responseData');
      int idFileUpload = responseData[0]['id'];
      return {
        'success': true,
        'idFileUpload': idFileUpload,
      };
    } catch (e) {
      print('Error uploading file: $e');
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
