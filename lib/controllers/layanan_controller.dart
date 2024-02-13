part of 'controller.dart';

class LayananController extends ChangeNotifier {
  List<Layanan> _layanans = [];
  List<Layanan> get layanans => _layanans;

  String _title = "SEMUA LAYANAN";
  String get title => _title;

  String _urlBackground = "";
  String get urlBackground => _urlBackground;

  String _intro = "";
  String get intro => _intro;

  List<bidang_layanan_model.BidangLayanan> _bidangLayanan = [];
  List<bidang_layanan_model.BidangLayanan> get bidangLayanans => _bidangLayanan;

  Layanan? _layanan;
  Layanan? get layanan => _layanan;

  void getDataLayanans({String? slug}) async {
    final List<Layanan> data;

    if (slug != null) {
      data = await LayananServices.getAllLayanans(
          filter: true, slugBidangLayanan: slug);
    } else {
      data = await LayananServices.getAllLayanans();
    }
    _layanans = data;
    notifyListeners();
  }

  void getAllBidangLayanan() async {
    final List<bidang_layanan_model.BidangLayanan> data =
        await LayananServices.getAllBidangLayanans();
    bidang_layanan_model.BidangLayanan newData =
        bidang_layanan_model.BidangLayanan(
      id: 0,
      attributes: bidang_layanan_model.Attributes(
        judul: 'Semua Layanan',
        intro: null,
        slug: null,
        createdAt: null,
        updatedAt: null,
      ),
    );
    data.insert(0, newData);
    _bidangLayanan = data;
    notifyListeners();
  }

  void getBidangLayananBySlug(String slug) async {
    bidang_layanan_model.BidangLayanan data =
        await LayananServices.getBidangLayananBySlug(slug);
    _title = data.attributes!.judul.toString();
    _urlBackground = data.attributes!.gambar!.data!.attributes!.url.toString();
    _intro = data.attributes!.intro.toString();
    notifyListeners();
  }

  void getLayananById(String id) async {
    final Layanan data = await LayananServices.getLayananById(id);
    _layanan = data;
    notifyListeners();
  }

  void getLayananBySlug(String slug) async {
    final Layanan data = await LayananServices.getLayananBySlug(slug);
    _layanan = data;
    notifyListeners();
  }

  void setLayananFromApi(Layanan? data) {
    _layanan = data;
    notifyListeners();
  }
}
