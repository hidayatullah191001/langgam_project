part of 'controller.dart';

class CheckoutController extends ChangeNotifier {
  TextEditingController namaDepanController = TextEditingController();
  TextEditingController namaBelakangController = TextEditingController();
  TextEditingController namaPerusahaanController = TextEditingController();
  TextEditingController alamatJalanController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController alamatEmailController = TextEditingController();
  TextEditingController catatanPesananController = TextEditingController();

  List<String> _keperluan = ['Komersial', 'Penelitian', 'Riset'];
  List<String> get keperluans => _keperluan;

  String? _selectedKeperluan;
  String? get selectedKeperluan => _selectedKeperluan;

  void setSelectedKeperluan(String value) {
    _selectedKeperluan = value;
    notifyListeners();
  }

  void prosesCheckout(
    BuildContext context, {
    required String provinsi,
    required String kota,
    required String kecamatan,
    required List cart,
  }) async {
    bool isKomersial = true;
    if (_selectedKeperluan == 'Komersial' || _selectedKeperluan == null) {
      isKomersial = true;
    } else {
      isKomersial = false;
    }
    final cartController = Provider.of<CartController>(context, listen: false);

    // print(namaDepanController.text);
    // print(namaBelakangController.text);
    // print(namaPerusahaanController.text);
    // print(provinsi);
    // print(kota);
    // print(kecamatan);
    // print(alamatJalanController.text);
    // print(kodePosController.text);
    // print(teleponController.text);
    // print(alamatEmailController.text);
    // print(selectedKeperluan);
    // print(catatanPesananController.text);

    if (namaDepanController.text.isEmpty ||
        namaBelakangController.text.isEmpty ||
        provinsi.isEmpty ||
        kota.isEmpty ||
        kecamatan.isEmpty ||
        alamatJalanController.text.isEmpty ||
        teleponController.text.isEmpty ||
        alamatEmailController.text.isEmpty ||
        selectedKeperluan!.isEmpty) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        width: MediaQuery.of(context).size.width * 0.3,
        text: 'Field mandatory harus diisi!',
      );
    } else if (!EmailValidator.validate(alamatEmailController.text)) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        width: MediaQuery.of(context).size.width * 0.3,
        text: 'Email yang dimasukkan tidak valid',
      );
    } else {
      Map<String, dynamic> response = {};
      for (var i = 0; i < cart.length; i++) {
        final data = cart[i];
        String lokasiPesanan = "${data['kota']} - ${data['provinsi']}";

        PermintaanFormModel model = PermintaanFormModel(
          data: Data(
            nama: "${namaDepanController.text} ${namaBelakangController.text}",
            email: alamatEmailController.text,
            alamat: alamatJalanController.text,
            telepon: teleponController.text,
            perusahaan: namaPerusahaanController.text,
            provinsi: AppMethods.convertToTitleCase(provinsi),
            kota: kota,
            kecamatan: kecamatan,
            status: "Menunggu Persetujuan",
            komersial: isKomersial,
            metadata: [
              Metadata(field: "Lokasi Pesanan", data: lokasiPesanan),
              Metadata(
                  field: "Catatan User", data: catatanPesananController.text),
            ],
            customerUser: data['user']['id'].toString(),
            harga: data['product']['harga'],
            kuantitas: int.parse(data['item']),
            layanan: data['product']['id'].toString(),
            total: cartController.getTotalHargaAllItem(),
          ),
        );
        response = await CheckoutService.createPermintaanUser(model);
      }
      if (response['success'] == true) {
        // permintaanModel.PermintaanModel permintaan =
        //     permintaanModel.PermintaanModel.fromJson(response['data']);
        cartController.setCartEmpty();
        // ignore: use_build_context_synchronously
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          width: MediaQuery.of(context).size.width * 0.3,
          text: 'Permintaan berhasil dibuat.',
          onConfirmBtnTap: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/cart/checkout/success',
            (route) => false,
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          width: MediaQuery.of(context).size.width * 0.3,
          text: response['error'],
        );
      }
    }
  }
}
