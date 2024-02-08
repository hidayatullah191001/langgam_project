part of 'controller.dart';

class WilayahController extends ChangeNotifier {
  List<Provinsi> _provinces = [];
  List<Kota> _cities = [];
  List<Kecamatan> _districts = [];

  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedDistrict;

  List<Provinsi> get provinces => _provinces;
  List<Kota> get cities => _cities;
  List<Kecamatan> get districts => _districts;

  String? get selectedProvince => _selectedProvince;
  String? get selectedCity => _selectedCity;
  String? get selectedDistrict => _selectedDistrict;

  void setSelectedProvince(String? province) {
    _selectedProvince = province;
    print('dari controller = $_selectedProvince');
    notifyListeners();
  }

  void setSelectedCity(String? city) {
    _selectedCity = city;
    notifyListeners();
  }

  void setSelectedDistrict(String? district) {
    _selectedDistrict = district;
    notifyListeners();
  }

  void getAllDataProvinces() async {
    List<Provinsi> dataProvinsis = await WilayahServices.getAllProvinsis();
    _provinces = dataProvinsis;
    notifyListeners();
  }

  // void getAllDataCities() async {
  //   List<Kota> dataCities = await WilayahServices.getAllKotas();
  //   _cities = dataCities;
  //   notifyListeners();
  // }

  // void getAllDataKecamatan() async {
  //   List<Kecamatan> dataDistricts = await WilayahServices.getAllKecamatan();
  //   _districts = dataDistricts;
  //   notifyListeners();
  // }

  void getAllDataCities(String namaProvinsi) async {
    List<Kota> dataCities = await WilayahServices.getAllKotas(namaProvinsi);
    _cities = dataCities;
    notifyListeners();
  }

  void getAllDataKecamatan(String namaKota) async {
    List<Kecamatan> dataDistricts =
        await WilayahServices.getAllKecamatan(namaKota);
    _districts = dataDistricts;
    notifyListeners();
  }

  List<Kota> getCitiesByProvince(String? provinceName) {
    return cities
        .where((city) => city.attributes!.namaProvinsi == provinceName)
        .toList();
  }

  List<Kecamatan> getDistrictsByCity(String cityName) {
    return districts
        .where((district) => district.attributes!.namaKota == cityName)
        .toList();
  }
}
