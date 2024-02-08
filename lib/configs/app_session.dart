part of 'configs.dart';

class AppSession {
  static Future<bool> saveUserInformation(Map user, String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('username', user['username']);
    await pref.setString('id', user['id']);
    await pref.setString('email', user['email']);
    await pref.setString('token', token);
    return true;
  }

  static Future<bool> saveDataCartUser(List cartUser) async {
    final pref = await SharedPreferences.getInstance();
    String cartString = json.encode(cartUser);
    return await pref.setString('carts', cartString);
  }

  static Future<String?> getDataCartUser()async{
    final pref = await SharedPreferences.getInstance();
    return pref.getString('carts');
  }

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
    pref.remove('id');
    pref.remove('username');
    pref.remove('email');
    pref.remove('token');
    return true;
  }
}
