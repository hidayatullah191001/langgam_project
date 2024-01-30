part of 'controller.dart';

class CartController extends ChangeNotifier {
  int _itemsCount = 1;

  // Bentuk Map

  /*
  {
    "product" : {
      "judul" : "JIJIJJI",
      "harga" : 2500000 
    },
    "totalItem" : [
      {
        "lokasi" : "Jawa Barat",
        "hari" : 2,
        "totalHarga" : "500000"
      },
      {
        "lokasi" : "Jakarta",
        "hari" : 1,
        "totalHarga" : "250000"
      }
    ],
  }
  */

  int _totalHarga = 0;

  List<Map<String, dynamic>> _cartList = [];
  List<Map<String, dynamic>> get carts => _cartList;
  int get itemsCount => _itemsCount;
  int get totalHarga => _totalHarga;

  void addToCart(Map<String, dynamic> product) {
    _cartList.add(product);
    notifyListeners();
  }

  void removeCart(index) {
    _cartList.removeAt(index);
  }

  void add() {
    _itemsCount += 1;
    notifyListeners();
  }

  void remover() {
    if (_itemsCount > 1) {
      _itemsCount -= 1;
      notifyListeners();
    }
  }

  total(int harga) {
    int total = harga * _itemsCount;
    _totalHarga = total;
    notifyListeners();
    return total;
  }
}
