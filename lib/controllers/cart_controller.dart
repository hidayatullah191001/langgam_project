part of 'controller.dart';

class CartController extends ChangeNotifier {
  int _itemsCount = 1;

  // Bentuk Map

  /*
  final productItem = {
                    'user': user,
                    'product': {
                      'id' : data.id
                      'judul': data.judul,
                      'harga': data.harga,
                      'satuan': data.satuan,
                      'gambar': data.gambar?.data?.attributes?.url,
                    },
                    'provinsi': wilayahController.selectedProvince,
                    'kota': wilayahController.selectedCity,
                    'kecamatan': wilayahController.selectedDistrict,
                    'item': controller.itemsCount.toString(),
                    'totalHarga': controller.totalHarga.toString(),
                  };
  */

  int _totalHarga = 0;

  List _cartList = [];
  List get carts => _cartList;

  // List _datacartList = [];
  // List get dataCarts => _datacartList;

  int get itemsCount => _itemsCount;
  int get totalHarga => _totalHarga;

  void setCartEmpty() {
    _cartList = [];
    AppSession.saveDataCartUser(_cartList);
    notifyListeners();
  }

  void setItemsCount(int count) {
    _itemsCount = count;
  }

  void setTotalHarga(int totalHarga) {
    _totalHarga = totalHarga;
  }

  void addToCart(Map<String, dynamic> product) {
    _cartList.add(product);
    AppSession.saveDataCartUser(_cartList);
    _itemsCount = 1;
    notifyListeners();
  }

  void removeCart(index) {
    _cartList.removeAt(index);
    AppSession.saveDataCartUser(_cartList);
    notifyListeners();
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

  void addinCartPage(int index) {
    int item = (int.parse(_cartList[index]['item']) + 1);
    _cartList[index]['item'] = item.toString();

    int total = _cartList[index]['product']['harga'] *
        int.parse(_cartList[index]['item']);
    _cartList[index]['totalHarga'] = total.toString();
    AppSession.saveDataCartUser(_cartList);
    notifyListeners();
  }

  void removerinCartPage(int index) {
    if (_itemsCount > 1) {
      int item = (int.parse(_cartList[index]['item']) - 1);
      _cartList[index]['item'] = item.toString();

      int total = _cartList[index]['product']['harga'] *
          int.parse(_cartList[index]['item']);
      _cartList[index]['totalHarga'] = total.toString();
      AppSession.saveDataCartUser(_cartList);
      notifyListeners();
    }
  }

  int getTotalHargaAllItem() {
    int totalHarga = 0;
    for (var cart in _cartList) {
      totalHarga += int.parse(cart['totalHarga']);
    }
    return totalHarga;
  }

  void setItemToFree() {
    for (var cart in _cartList) {
      cart['totalHarga'] = 0.toString();
    }
    AppSession.saveDataCartUser(_cartList);
    notifyListeners();
  }

  void setItemToKomersial() {
    for (var cart in _cartList) {
      int hargaProduk = cart['product']['harga'];
      int itemCountProduct = int.parse(cart['item']);
      int total = hargaProduk * itemCountProduct;
      cart['totalHarga'] = total.toString();
    }
    AppSession.saveDataCartUser(_cartList);
    notifyListeners();
  }

  total(int harga) {
    int total = harga * _itemsCount;
    _totalHarga = total;
    return total;
  }

  void getDataCart() async {
    final String? stringDataCart = await AppSession.getDataCartUser();
    if (stringDataCart != null) {
      List dataCart = json.decode(stringDataCart.toString());
      _cartList = dataCart;
    } else {
      _cartList = [];
    }
  }
}
