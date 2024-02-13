part of 'controller.dart';

class BeritaController extends ChangeNotifier {
  BeritaModel? _berita;
  BeritaModel get berita => _berita!;

  void getBeritaBySlug(String slug) async {
    BeritaModel data = await BeritaService.getBeritaBySlug(slug);
    _berita = data;
    notifyListeners();
  }
}
