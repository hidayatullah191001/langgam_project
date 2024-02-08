part of 'controller.dart';

class AuthController extends ChangeNotifier {
  Future loginUser(SignInFormModel model) async {
    final result = await AuthServices.signIn(model);
    if (result) {
      return true;
    } else {
      return false;
    }
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
