part of 'controller.dart';

class AuthController extends ChangeNotifier {
  Future<Map<String, dynamic>> loginUser(SignInFormModel model) async {
    final result = await AuthServices.signIn(model);
    return result;
  }

  Future<Map<String, dynamic>> registerUser(SignUpFormModel model) async {
    final result = await AuthServices.register(model);
    return result;
  }

  logout() async {
    final result = await AppSession.removeUserInformation();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
