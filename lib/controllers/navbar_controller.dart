part of 'controller.dart';

class NavbarController extends ChangeNotifier {
  String _selectedDrawer = "Login";

  String get selectedDrawer => _selectedDrawer;

  void pickDrawer(String drawer) {
    _selectedDrawer = drawer;
    notifyListeners();
  }
}
