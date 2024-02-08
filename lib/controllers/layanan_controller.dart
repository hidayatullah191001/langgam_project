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

  List<BidangLayanan> _bidangLayanan = [];
  List<BidangLayanan> get bidangLayanans => _bidangLayanan;

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
    final List<BidangLayanan> data =
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

  void getBidangLayananBySlug(int? id) async {
    BidangLayanan data = await LayananServices.getBidangLayananById(id);
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

  void setLayananFromApi(Layanan? data) {
    _layanan = data;
    notifyListeners();
  }
}
