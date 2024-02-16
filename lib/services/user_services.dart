part of 'services.dart';

class UserServices {
  static Future<UserAccount> getDataInformationUser() async {
    final token = await AppSession.getToken();

    Map? responseBody = await APIRequest.gets(
      '${Constant.apirest}/users/me',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (responseBody! != null) {
      return UserAccount.fromJson(responseBody as Map<String, dynamic>);
    } else {
      return throw "Data kosong";
    }
  }
}
