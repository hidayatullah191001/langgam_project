part of 'controller.dart';

class MyAccountController extends ChangeNotifier {
  String _selectedMenu = "Dasbor";
  int _selectedIndex = 0;

  String get selectedMenu => _selectedMenu;
  int get selectedIndex => _selectedIndex;

  void pickMenu(String menu, int index) {
    _selectedMenu = menu;
    _selectedIndex = index;
    notifyListeners();
  }
}
