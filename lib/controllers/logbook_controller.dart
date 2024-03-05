part of 'controller.dart';

class LogbookController extends ChangeNotifier {
  TextEditingController namaPemohanController = TextEditingController();
  TextEditingController namaPetugasController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController waktuPengerjaanController = TextEditingController();
  TextEditingController pembayaranController = TextEditingController();
  TextEditingController waktuPengambilan = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  final List<String> _perihalPermohonan = ['Kalibrasi', 'Data MKG'];
  List<String> get perihalPermohonans => _perihalPermohonan;

  // final List<String> _statuses = ['On Process', 'Selesai'];
  // List<String> get statuses => _statuses;

  String? _selectedPerihalPermohonan;
  String? get selectedPerihalPermohonan => _selectedPerihalPermohonan;

  void setSelectedPerihalPermohonan(String value) {
    _selectedPerihalPermohonan = value;
  }

  // String? _selectedStatus;
  // String? get selectedStatus => _selectedStatus;

  // void setSelectedStatus(String value) {
  //   _selectedStatus = value;
  // }

  void createLogbookAdmin(BuildContext context) async {
    final userLogin = await AppSession.getUserInformation();
    String idUser = userLogin['id'];

    if (_selectedPerihalPermohonan!.isEmpty ||
        namaPetugasController.text.isEmpty ||
        namaPemohanController.text.isEmpty ||
        nomorTeleponController.text.isEmpty ||
        waktuPengerjaanController.text.isEmpty ||
        pembayaranController.text.isEmpty ||
        waktuPengambilan.text.isEmpty) {
      AppMethods.dangerToast(context, "Field mandatory tidak boleh kosong");
    } else {
      final data = LogbookFormModel(
        data: LogbookFormData(
          perihalPermohonan: _selectedPerihalPermohonan,
          namaPemohon: namaPemohanController.text,
          nomorTelepon: nomorTeleponController.text,
          waktuPengerjaan: waktuPengerjaanController.text,
          pembayaran: int.parse(pembayaranController.text),
          status: null,
          waktuPengambilan: waktuPengambilan.text,
          keterangan: keteranganController.text,
          petugas: idUser,
          namaPetugas: namaPetugasController.text,
        ),
      );

      final result = await LogbookService.createLogbook(data);

      if (result['success'] == true) {
        AppMethods.successToast(context, 'Logbook created successfully');
        setEmptyVariable();
        setSelectedPerihalPermohonan('');
        // setSelectedStatus('');
      } else {
        AppMethods.dangerToast(context, result['error']);
      }
    }
  }

  void updateLogbookAdmin(BuildContext context, String id) async {
    final userLogin = await AppSession.getUserInformation();
    String idUser = userLogin['id'];

    if (_selectedPerihalPermohonan!.isEmpty ||
        namaPemohanController.text.isEmpty ||
        namaPetugasController.text.isEmpty ||
        nomorTeleponController.text.isEmpty ||
        waktuPengerjaanController.text.isEmpty ||
        pembayaranController.text.isEmpty ||
        waktuPengambilan.text.isEmpty) {
      AppMethods.dangerToast(context, "Field mandatory tidak boleh kosong");
    } else {
      final data = LogbookFormModel(
        data: LogbookFormData(
          perihalPermohonan: _selectedPerihalPermohonan,
          namaPemohon: namaPemohanController.text,
          nomorTelepon: nomorTeleponController.text,
          waktuPengerjaan: waktuPengerjaanController.text,
          pembayaran: int.parse(pembayaranController.text),
          status: null,
          waktuPengambilan: waktuPengambilan.text,
          keterangan: keteranganController.text,
          petugas: idUser,
          namaPetugas: namaPetugasController.text,
        ),
      );

      final result = await LogbookService.updateLogbook(data, id);
      if (result['success'] == true) {
        AppMethods.successToast(context, 'Logbook updated successfully');
        setEmptyVariable();
      } else {
        AppMethods.dangerToast(context, result['error']);
      }
    }
  }

  void deleteLogbookAdmin(BuildContext context, String id) async {
    final result = await LogbookService.deleteLogbook(id);
    if (result['success'] == true) {
      AppMethods.successToast(context, 'Data logbook berhasil dihapus');
      notifyListeners();
    } else {
      AppMethods.dangerToast(context, result['message']);
    }
  }

  void setDefaultUpdateValue(LogbookAttributes model) {
    keteranganController.text = model.keterangan ?? '';
    namaPemohanController.text = model.namaPemohon ?? '';
    nomorTeleponController.text = model.nomorTelepon ?? '';
    pembayaranController.text = model.pembayaran.toString();
    waktuPengerjaanController.text = model.waktuPengerjaan ?? '';
    waktuPengambilan.text = model.waktuPengambilan ?? '';
    namaPetugasController.text = model.namaPetugas ?? '';
    _selectedPerihalPermohonan = model.perihalPermohonan ?? '';
    notifyListeners();
  }

  void setEmptyVariable() {
    keteranganController.text = '';
    namaPemohanController.text = '';
    nomorTeleponController.text = '';
    pembayaranController.text = '';
    waktuPengerjaanController.text = '';
    waktuPengambilan.text = '';
    namaPetugasController.text = '';
    _selectedPerihalPermohonan = null;
    notifyListeners();
  }
}
