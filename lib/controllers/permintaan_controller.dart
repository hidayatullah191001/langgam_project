part of 'controller.dart';

class PermintaanController extends ChangeNotifier {
  List<listPermintaanModel.ListPermintaanModel> _listPermintaans = [];
  List<listPermintaanModel.ListPermintaanModel> get permintaans =>
      _listPermintaans;

  listPermintaanModel.Data? _dataPermintaan;
  listPermintaanModel.Data get dataPermintaan => _dataPermintaan!;

  void setDataPermintaan(dynamic data) {
    _dataPermintaan = data as listPermintaanModel.Data;
    notifyListeners();
}

  // void getPermintaanUser() async {
  //   // List<listPermintaanModel.ListPermintaanModel> data =
  //   //     await PermintaanService.getAllPermintaanCustomer();

  //   // _listPermintaans = data;

  //   listPermintaanModel.ListPermintaanModel data =
  //       await PermintaanService.getAllPermintaanCustomer();
  //   _permintaan = data;
  //   notifyListeners();
  // }
}
