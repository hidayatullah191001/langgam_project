part of 'services.dart';

class SettingService {
  static Future<SettingWebModel> getSettingApp() async {
    Map? responseBody =
        await APIRequest.gets('${Constant.apirest}/setting?populate=*');

    if (responseBody!['data'] != null) {
      return SettingWebModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      return throw "Data kosong";
    }
  }
}
