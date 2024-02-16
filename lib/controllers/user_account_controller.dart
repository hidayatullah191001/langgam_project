part of 'controller.dart';

class UserAccountController extends ChangeNotifier {
  UserAccount? _user;
  UserAccount get user => _user!;

  DataState dataState = DataState.loading;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getUserInformation() async {
    changeState(DataState.loading);
    try {
      UserAccount data = await UserServices.getDataInformationUser();
      _user = data;
      usernameController.text = data.username.toString();
      emailController.text = data.email.toString();
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
