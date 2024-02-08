part of 'services.dart';

class AuthServices {
  static Future signIn(SignInFormModel value) async {
    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/auth/local',
      body: value.toJson(),
    );
    if (responseBody == null) return false;
    if (responseBody.isNotEmpty) {
      // print(responseBody);
      String token = responseBody['jwt'].toString();
      String email = responseBody['user']['email'].toString();
      String id = responseBody['user']['id'].toString();
      String username = responseBody['user']['username'].toString();
      print(token);
      Map user = {
        'username': username,
        'email': email,
        'id': id,
      };
      AppSession.saveUserInformation(user, token);
      return true;
    }
    return false;
  }

  // static Future logout()async{
  //    AppSession.saveUserInformation(
  //       {
  //         'email': responseBody['user']['email'],
  //         'id': responseBody['user']['id'],
  //         'username': responseBody['user']['username'],
  //       },
  //       token,
  //     );
  //     return true
  // }
}
