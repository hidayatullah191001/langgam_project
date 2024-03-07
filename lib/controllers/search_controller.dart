part of 'controller.dart';

class PencarianController extends ChangeNotifier {
  TextEditingController cariController = TextEditingController();
  String? value;
  String get valueSearch => value!;

  bool _isSearchBoolean = false;
  bool get isSearchBoolean => _isSearchBoolean;

  void setValueSearch(String? v) {
    value = v!;
    if (value == '') {
      _isSearchBoolean = false;
    }
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
