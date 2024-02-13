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

  listPermintaanModelAdmin.PermintaanAdminData? _permintaanAdmin;
  listPermintaanModelAdmin.PermintaanAdminData get permintaanAdmin =>
      _permintaanAdmin!;

  listPermintaanModelAdmin.ListPermintaanModelAdmin?
      _permintaanMenungguPersetujuan;
  listPermintaanModelAdmin.ListPermintaanModelAdmin
      get permintaanMenungguPersetujuan => _permintaanMenungguPersetujuan!;

  listPermintaanModelAdmin.ListPermintaanModelAdmin?
      _permintaanVertifikasiPersyaratan;
  listPermintaanModelAdmin.ListPermintaanModelAdmin
      get permintaanVerifikasiPersyaratan => _permintaanVertifikasiPersyaratan!;

  String? _countMenungguPersetujuan;
  String? get countMenungguPersetujuan => _countMenungguPersetujuan;

  String? _countVerifikasiPersyaratan;
  String? get countVerifikasiPersyaratan => _countVerifikasiPersyaratan;

  String? _countMenungguPembayaran;
  String? get countMenungguPembayaran => _countMenungguPembayaran;

  String? _countVerifikasiPembayaran;
  String? get countVerifikasiPembayaran => _countVerifikasiPembayaran;

  String? _countSedangDiproses;
  String? get countSedangDiproses => _countSedangDiproses;

  String? _countSelesai;
  String? get countSelesai => _countSelesai;

  String? _countKomersial;
  String? get countKomersial => _countKomersial;

  int? _totalPendapatanKotor;
  int? get totalPendapatanKotor => _totalPendapatanKotor;

  int? _totalPendapatanSelesai;
  int? get totalPendapatanSelesai => _totalPendapatanSelesai;

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

  DataState dataState = DataState.loading;

  void changeState(DataState state) {
    dataState = state;
    notifyListeners();
  }

  void setSelectedStatus(String value) {
    _selectedStatus = value;
    notifyListeners();
  }

  void setDataPermintaan(dynamic data) {
    _dataPermintaan = data as listPermintaanModel.Data;
    notifyListeners();
  }

  void setDataPermintaanAdmin(dynamic data) {
    _permintaanAdmin = data as listPermintaanModelAdmin.PermintaanAdminData;
    notifyListeners();
  }

  getCountPermintaanByStatus() async {
    changeState(DataState.loading);
    try {
      listPermintaanModelAdmin.ListPermintaanModelAdmin menungguPersetujuan =
          await PermintaanService.getAllPermintaanByStatus(
              'Menunggu Persetujuan');
      listPermintaanModelAdmin.ListPermintaanModelAdmin verifikasiPersyaratan =
          await PermintaanService.getAllPermintaanByStatus(
              'Verifikasi Persyaratan');
      listPermintaanModelAdmin.ListPermintaanModelAdmin menungguPembayaran =
          await PermintaanService.getAllPermintaanByStatus(
              'Menunggu Pembayaran');
      listPermintaanModelAdmin.ListPermintaanModelAdmin verifikasiPembayaran =
          await PermintaanService.getAllPermintaanByStatus(
              'Verifikasi Pembayaran');

      listPermintaanModelAdmin.ListPermintaanModelAdmin sedangDiproses =
          await PermintaanService.getAllPermintaanByStatus('Sedang Diproses');

      listPermintaanModelAdmin.ListPermintaanModelAdmin selesai =
          await PermintaanService.getAllPermintaanByStatus('Selesai');
      // Perhitungan untuk pendapatan kotor
      listPermintaanModelAdmin.ListPermintaanModelAdmin all =
          await PermintaanService.getAllPermintaan();

      _countMenungguPersetujuan =
          menungguPersetujuan.meta!.pagination!.total.toString();
      _countVerifikasiPersyaratan =
          verifikasiPersyaratan.meta!.pagination!.total.toString();
      _countMenungguPembayaran =
          menungguPembayaran.meta!.pagination!.total.toString();
      _countVerifikasiPembayaran =
          verifikasiPembayaran.meta!.pagination!.total.toString();
      _countSedangDiproses = sedangDiproses.meta!.pagination!.total.toString();
      _countSelesai = selesai.meta!.pagination!.total.toString();

      int totalHargaKotor = 0;
      for (var item in all.data!) {
        totalHargaKotor += item.attributes!.total!;
      }
      _totalPendapatanKotor = totalHargaKotor;

      // Perhitungan untuk pendapatan selesai
      int totalHargaSelesai = 0;
      for (var item in selesai.data!) {
        totalHargaSelesai += item.attributes!.total!;
      }
      _totalPendapatanSelesai = totalHargaSelesai;

      // Count by Komersial
      listPermintaanModelAdmin.ListPermintaanModelAdmin komersial =
          await PermintaanService.getAllPermintaanByKomersial();
      _countKomersial = komersial.meta!.pagination!.total.toString();
      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }

  void getAllPermintaanByDate(String startDate, String finishDate,
      {int? page}) async {
    changeState(DataState.loading);
    try {
      final data;
      if (startDate.isNotEmpty || finishDate.isNotEmpty) {
        data = await PermintaanService.getAllPermintaanByDate(
            startDate: startDate, finishDate: finishDate, page: page);
      } else {
        data = await PermintaanService.getAllPermintaan(page: page);
      }
      _permintaan = data;

      changeState(DataState.filled);
    } catch (e) {
      changeState(DataState.error);
    }
  }
}
