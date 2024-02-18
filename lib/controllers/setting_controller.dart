part of 'controller.dart';

class SettingController extends ChangeNotifier {
  SettingWebModel _setting = SettingWebModel();
  SettingWebModel get setting => _setting;

  DataState dataState = DataState.loading;

  void changeState(DataState state) {
    dataState = state;
  }

  void getSettingWeb() async {
    changeState(DataState.loading);
    try {
      SettingWebModel data = await SettingService.getSettingApp();
      _setting = data;
      changeState(DataState.filled);
      notifyListeners();
    } catch (e) {
      changeState(DataState.error);
      notifyListeners();
    }
  }
}
