part of 'services.dart';

class AuthServices {
  static Future<Map<String, dynamic>> signIn(SignInFormModel value) async {
    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/auth/local?populate=*',
      body: value.toJson(),
    );
    if (responseBody!.isNotEmpty) {
      if (responseBody['jwt'] != null) {
        String token = responseBody['jwt'].toString();
        String email = responseBody['user']['email'].toString();
        String id = responseBody['user']['id'].toString();
        String username = responseBody['user']['username'].toString();
        String role = "";

        Map? responseDetailUser = await APIRequest.gets(
            "${Constant.apirest}/users/me?populate=*",
            headers: {
              'Authorization': 'Bearer $token',
            });

        if (responseDetailUser!.isNotEmpty) {
          role = responseDetailUser['role']['type'];
        }

        if (role == 'customer') {
          Map user = {
            'username': username,
            'email': email,
            'id': id,
            'role': role,
          };
          if (responseBody['blocked'] == true) {
            return {
              "success": false,
              "message": "Akun anda belum diaktivasi, silahkan hubungi admin",
            };
          } else {
            AppSession.saveUserInformation(user, token);
            return {
              "success": true,
              "message": "Berhasil login",
            };
          }
        } else {
          return {
            "success": false,
            "message": "Akun kamu tidak memiliki akses ke halaman ini"
          };
        }
      } else {
        return {
          "success": false,
          "message": "Email atau password salah, coba lagi",
        };
      }
    }

    return {
      "success": false,
      "message": "Something went wrong",
    };
  }

  static Future<Map<String, dynamic>> signInAdmin(SignInFormModel value) async {
    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/auth/local?populate=*',
      body: value.toJson(),
    );
    if (responseBody!.isNotEmpty) {
      if (responseBody['jwt'] != null) {
        String token = responseBody['jwt'].toString();
        String email = responseBody['user']['email'].toString();
        String id = responseBody['user']['id'].toString();
        String username = responseBody['user']['username'].toString();
        String role = "";

        Map? responseDetailUser = await APIRequest.gets(
            "${Constant.apirest}/users/me?populate=*",
            headers: {
              'Authorization': 'Bearer $token',
            });

        if (responseDetailUser!.isNotEmpty) {
          role = responseDetailUser['role']['type'];
        }

        if (role == 'authenticated') {
          Map user = {
            'username': username,
            'email': email,
            'id': id,
            'role': role,
          };
          if (responseBody['blocked'] == true) {
            return {
              "success": false,
              "message": "Akun anda belum diaktivasi, silahkan hubungi admin",
            };
          } else {
            AppSession.saveUserInformation(user, token);
            return {
              "success": true,
              "message": "Berhasil login",
            };
          }
        } else {
          return {
            "success": false,
            "message": "Akun kamu tidak memiliki akses ke halaman admin",
          };
        }
      } else {
        return {
          "success": false,
          "message": "Email atau password salah, coba lagi",
        };
      }
    }

    return {
      "success": false,
      "message": "Something went wrong",
    };
  }

  static Future<Map<String, dynamic>> register(SignUpFormModel value) async {
    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/auth/local/register',
      body: value.toJson(),
    );
    if (responseBody!.isNotEmpty) {
      if (responseBody['jwt'] != null) {
        // String token = responseBody['jwt'].toString();
        // String email = responseBody['user']['email'].toString();
        // String id = responseBody['user']['id'].toString();
        // String username = responseBody['user']['username'].toString();
        // String role = responseBody['role']['type'].toString();
        // // Map user = {
        // //   'username': username,
        // //   'email': email,
        // //   'id': id,
        // //   'role': role,
        // // };
        // // AppSession.saveUserInformation(user, token);
        return {
          "success": true,
          "message":
              "Akun berhasil didaftarkan, silahkan cek email untuk aktivasi",
        };
      } else {
        return {
          "success": false,
          "message": "Ada kesalahan di server, coba lagi!.",
        };
      }
    }

    return {
      "success": false,
      "message": "Something went wrong",
    };
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
