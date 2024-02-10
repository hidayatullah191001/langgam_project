part of 'controller.dart';

class PermintaanController extends ChangeNotifier {
  TextEditingController nomorBillingController = TextEditingController();

  List<listPermintaanModel.ListPermintaanModel> _listPermintaans = [];
  List<listPermintaanModel.ListPermintaanModel> get permintaans =>
      _listPermintaans;

  listPermintaanModel.Data? _dataPermintaan;
  listPermintaanModel.Data get dataPermintaan => _dataPermintaan!;

  listPermintaanModelAdmin.ListPermintaanModelAdmin? _permintaan;
  listPermintaanModelAdmin.ListPermintaanModelAdmin get permintaan =>
      _permintaan!;

  listPermintaanModelAdmin.Data? _permintaanAdmin;
  listPermintaanModelAdmin.Data get permintaanAdmin => _permintaanAdmin!;

  List<String> _status = [
    'Menunggu Persetujuan',
    'Verifikasi Persyaratan',
    'Menunggu Pembayaran',
    'Verifikasi Pembayaran',
    'Sedang Diproses',
    'Selesai'
  ];
  List<String> get statuses => _status;

  String? _selectedStatus;
  String? get selectedStatus => _selectedStatus;

  void setSelectedStatus(String value) {
    _selectedStatus = value;
    notifyListeners();
  }

  void getAllPermintaan() async {
    listPermintaanModelAdmin.ListPermintaanModelAdmin data =
        await PermintaanService.getAllPermintaan();
    _permintaan = data;
    notifyListeners();
  }

  void setDataPermintaan(dynamic data) {
    _dataPermintaan = data as listPermintaanModel.Data;
    notifyListeners();
  }

  void setDataPermintaanAdmin(dynamic data) {
    _permintaanAdmin = data as listPermintaanModelAdmin.Data;
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
