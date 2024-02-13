part of 'controller.dart';

class BantuanController extends ChangeNotifier {
  BantuanModel? _bantuan;
  BantuanModel get bantuan => _bantuan!;

  DataState dataState = DataState.loading;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void getBantuanBySlug(String slug) async {
    changeState(DataState.loading);
    try {
      final BantuanModel data = await BantuanService.getBantuanBySlug(slug);
      _bantuan = data;
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
