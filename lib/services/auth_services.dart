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
    String activationToken =
        generateActivationToken(); // Implementasikan fungsi ini
    String activationLink =
        '${Constant.apirest}/activate?token=$activationToken';
    await sendActivationEmail(value.email!, activationLink);
    return {};
    // Map? responseBody = await APIRequest.post(
    //   '${Constant.apirest}/auth/local/register',
    //   body: value.toJson(),
    // );
    // if (responseBody!.isNotEmpty && responseBody['jwt'] != null) {
    //   String email = responseBody['user']['email'].toString();
    //   String activationToken =
    //       generateActivationToken(); // Implementasikan fungsi ini
    //   String activationLink =
    //       '${Constant.apirest}/activate?token=$activationToken';

    //   // Kirim email aktivasi
    //   await sendActivationEmail(email, activationLink);

    //   return {
    //     "success": true,
    //     "message":
    //         "Akun berhasil didaftarkan, silahkan cek email untuk aktivasi",
    //   };
    // } else {
    //   return {
    //     "success": false,
    //     "message": "Ada kesalahan di server, coba lagi!.",
    //   };
    // }
  }

  static Future<void> sendActivationEmail(
      String recipientEmail, String activationLink) async {
    final smtpServer = gmail('hidayatullahbp@gmail.com',
        '#Dayat1910'); // Ganti dengan kredensial SMTP yang valid

    final message = Message()
      ..from = Address('admin@langgam.bmkg.go.id',
          'admin@langgam.bmkg.go.id') // Ganti dengan alamat email pengirim dan nama Anda
      ..recipients.add(recipientEmail)
      ..subject = 'Aktivasi Akun'
      ..text =
          'Terima kasih atas registrasinya! Silahkan aktivasi akun Anda melalui tautan berikut: $activationLink';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error occurred while sending activation email: $e');
      // Anda dapat menangani kesalahan pengiriman email di sini sesuai kebutuhan
    }
  }

  // Fungsi untuk menghasilkan token aktivasi (contoh sederhana, gantilah dengan implementasi yang lebih aman)
  static String generateActivationToken() {
    return DateTime.now().millisecondsSinceEpoch.toRadixString(16);
  }

  static Future<void> handleGoogleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      // Membuka dialog login Google
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Berhasil login, dapatkan informasi akun
        print('User ID: ${googleSignInAccount.id}');
        print('Display Name: ${googleSignInAccount.displayName}');
        print('Email: ${googleSignInAccount.email}');
        print('Profile Picture: ${googleSignInAccount.photoUrl}');
      } else {
        // Pembatalan login oleh pengguna
        print('Login dibatalkan.');
      }
    } catch (error) {
      print('Error during Google sign in: $error');
    }
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
