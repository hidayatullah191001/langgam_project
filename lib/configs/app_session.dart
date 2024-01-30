part of 'configs.dart';

class AppSession {
  static Future<bool> saveUserInformation(Map user, String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('username', user['username']);
    await pref.setString('id', user['id']);
    await pref.setString('email', user['email']);
    return await pref.setString('token', token);
  }

  static Future<bool> saveDataCartUser(Map data) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString('data', data.toString());
  }

  // static Future<Map<String, dynamic>> getDataCartUser()async{
  //   final pref = await SharedPreferences.getInstance();
  //   return pref.getString('data');
  // }

  static Future<Map<String, dynamic>> getUserInformation() async {
    final pref = await SharedPreferences.getInstance();
    return {
      'id': pref.getString('id'),
      'username': pref.getString('username'),
      'email': pref.getString('email'),
      'token': pref.getString('token'),
    };
  }

  static Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token').toString();
  }

  static Future<bool> removeUserInformation() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('email');
    pref.remove('password');
    pref.remove('token');
    return true;
  }
}
