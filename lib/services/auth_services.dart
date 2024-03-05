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
            "message": responseBody['error']['message'],
          };
        }
      } else {
        return {
          "success": false,
          "message": responseBody['error']['message'],
        };
      }
    }

    return {
      "success": false,
      "message": responseBody['error']['message'],
    };
  }

  static Future<Map<String, dynamic>> register(SignUpFormModel value) async {
    Map? responseBody = await APIRequest.post(
      '${Constant.apirest}/auth/local/register',
      body: value.toJson(),
    );

    if (responseBody!.isNotEmpty) {
      if (responseBody['jwt'] != null) {
        String token = responseBody['jwt'].toString();
        String email = responseBody['user']['email'].toString();
        String id = responseBody['user']['id'].toString();
        String username = responseBody['user']['username'].toString();
        String role = responseBody['user']['role']['type'].toString();

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
              "message": "Berhasil daftar",
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
    } else {
      return {
        "success": false,
        "message": responseBody['error']['message'],
      };
    }
  }

  static Future<Map<String, dynamic>> registerGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      // Membuka dialog login Google
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Berhasil login, dapatkan informasi akun
        final account = {
          "email": googleSignInAccount.email,
          "username": googleSignInAccount.displayName,
          "firstName": googleSignInAccount.displayName,
          "password": "rahasia",
          "lastName": "",
          "blocked": "false",
        };

        Map? responseBody = await APIRequest.post(
          '${Constant.apirest}/auth/local/register',
          body: account,
          headers: {
            "Content-Type": "application/json",
          },
        );
        if (responseBody!.isNotEmpty && responseBody['jwt'] != null) {
          return {
            "success": true,
            "message":
                "Akun berhasil didaftarkan, silahkan cek email untuk aktivasi",
          };
        } else {
          return {
            "success": false,
            "message": responseBody['error']['message'],
          };
        }
      } else {
        // Pembatalan login oleh pengguna
        return {
          "success": false,
          "message": "Register dibatalkan pengguna",
        };
      }
    } catch (error) {
      return {
        "success": false,
        "message": "Error during Google sign in: $error",
      };
    }
  }
}
