part of 'controller.dart';

class PencarianController extends ChangeNotifier {
  String? value;
  String get valueSearch => value!;

  bool _isSearchBoolean = false;
  bool get isSearchBoolean => _isSearchBoolean;

  void setValueSearch(String? v) {
    value = v!;
    notifyListeners();
  }

  void setSearchBoolean(bool v) {
    _isSearchBoolean = v;
    notifyListeners();
  }

  // void setSearchController(String? v) {
  //   search.text = v!;
  //   notifyListeners();
  // }
}
