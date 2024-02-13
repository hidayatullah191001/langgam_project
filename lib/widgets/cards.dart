part of 'widgets.dart';

class LayananCard extends StatefulWidget {
  final int index;
  final String imagePath;
  final String titleLayanan;
  final String descriptionLayanan;

  LayananCard({
    required this.index,
    required this.imagePath,
    required this.titleLayanan,
    required this.descriptionLayanan,
  });

  @override
  _LayananCardState createState() => _LayananCardState();
}

class _LayananCardState extends State<LayananCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        width: 260,
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: isHovered ? 0.0 : -15.0,
              bottom: isHovered ? 0.0 : -15.0,
              left: isHovered ? 0.0 : -15.0,
              right: isHovered ? 0.0 : -15.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isHovered ? 0.5 : 0.0,
              child: Container(
                color: Colors.black,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.titleLayanan,
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: AppTheme.semiBold,
                      ),
                    ),
                  ),
                  isHovered
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                        )
                      : AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 0,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isHovered ? 1.0 : 0.0,
                      child: Text(
                        widget.descriptionLayanan,
                        style: AppTheme.whiteTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

class LayananPopulerCard extends StatefulWidget {
  final layanan.Attributes? data;
  final String idProduct;
  const LayananPopulerCard(
      {Key? key, required this.data, required this.idProduct})
      : super(key: key);

  @override
  State<LayananPopulerCard> createState() => _LayananPopulerCardState();
}

class _LayananPopulerCardState extends State<LayananPopulerCard> {
  bool isHovered = false;

  Map<String, dynamic> user = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    context.read<WilayahController>().getAllDataProvinces();
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    '${Constant.host}${widget.data?.gambar?.data?.attributes?.url.toString()}' ??
                        'https://cdn.pixabay.com/photo/2015/09/16/08/55/online-942408_960_720.jpg',
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 0.5 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isHovered ? 1.0 : 0.0,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: ModalInformationCart(
                                    context, widget.data, widget.idProduct),
                              );
                            },
                          );
                        }, // Button add item to cart
                        child: Container(
                          width: 50,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.whiteColor, width: 2),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: AppColors.whiteColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                widget.data!.judul.toString(),
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppMethods.currency(widget.data!.harga.toString()),
              style: AppTheme.primaryTextStyle.copyWith(
                fontWeight: AppTheme.semiBold,
              ),
            ),
            Text(
              widget.data!.satuan.toString(),
              style: AppTheme.greyTextStyle.copyWith(
                fontWeight: AppTheme.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ModalInformationCart(
      BuildContext context, dynamic data, String idProduct) {
    final controller = context.watch<CartController>();
    final wilayahController = context.watch<WilayahController>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(35),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${Constant.host}${data.gambar?.data?.attributes?.url.toString()}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.judul.toString(),
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data.intro.toString(),
                        style: AppTheme.greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: AppTheme.medium,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.remover();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                ),
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: AppColors.primaryColor,
                                size: 19,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.blue.withOpacity(0.1),
                            child: Text(
                              controller.itemsCount.toString(),
                              style: AppTheme.blackTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: AppTheme.medium,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.add();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Harga', style: AppTheme.blackTextStyle),
                          Text(
                            AppMethods.currency(
                                controller.total(data.harga).toString()),
                            style: AppTheme.primaryTextStyle.copyWith(
                                fontWeight: AppTheme.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 10,
            ),
            // START PROVINSI
            DropdownButtonFormField<String>(
              value: wilayahController.selectedProvince,
              onChanged: (String? value) {
                setState(() {
                  wilayahController.setSelectedProvince(value);
                  wilayahController.setSelectedCity(null);
                  wilayahController.setSelectedDistrict(null);
                });
                if (wilayahController.selectedProvince!.isNotEmpty) {
                  wilayahController
                      .getAllDataCities(wilayahController.selectedProvince!);
                }
              },
              decoration: InputDecoration(
                hintStyle: AppTheme.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.greyColor, width: 2),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              items: wilayahController.provinces.map((data) {
                return DropdownMenuItem<String>(
                  value: data.attributes!.namaProvinsi,
                  child: Text(data.attributes!.namaProvinsi.toString()),
                );
              }).toList(),
              hint: Text('Pilih Provinsi', style: AppTheme.greyTextStyle),
            ),
            // END PROVINSI
            const SizedBox(
              height: 10,
            ),
            // START OF KOTAS
            DropdownButtonFormField<String>(
              value: wilayahController.selectedCity,
              onChanged: (String? value) {
                setState(() {
                  wilayahController.setSelectedCity(value);
                  wilayahController.setSelectedDistrict(null);
                });
                if (wilayahController.selectedCity!.isNotEmpty) {
                  wilayahController
                      .getAllDataKecamatan(wilayahController.selectedCity!);
                }
              },
              decoration: InputDecoration(
                hintStyle: AppTheme.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.greyColor, width: 2),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              items: wilayahController
                  .getCitiesByProvince(wilayahController.selectedProvince ?? "")
                  .map((city) {
                return DropdownMenuItem<String>(
                  value: city.attributes!.namaKota,
                  child: Text(city.attributes!.namaKota.toString()),
                );
              }).toList(),
              hint: Text('Pilih Kota', style: AppTheme.greyTextStyle),
            ),
            // END OF KOTAS
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 12,
            ),
            PrimaryButton(
              onTap: () {
                if (user['token'] == null &&
                    user['email'] == null &&
                    user['id'] == null) {
                  CoolAlert.show(
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.3,
                    type: CoolAlertType.error,
                    text: 'Maaf, kamu harus login terlebih dahulu',
                  ).then((value) => context.go('/register'));
                } else {
                  final productItem = {
                    'user': user,
                    'product': {
                      'id': idProduct,
                      'judul': data.judul,
                      'harga': data.harga,
                      'satuan': data.satuan,
                      'gambar': data.gambar?.data?.attributes?.url,
                    },
                    'provinsi': wilayahController.selectedProvince,
                    'kota': wilayahController.selectedCity,
                    'item': controller.itemsCount.toString(),
                    'totalHarga': controller.totalHarga.toString(),
                  };
                  controller.addToCart(productItem);
                  CoolAlert.show(
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.3,
                    type: CoolAlertType.success,
                    text: 'Product berhasil ditambahkan kedalam keranjang',
                  );
                  wilayahController.setSelectedProvince(null);
                  wilayahController.setSelectedCity(null);
                }
              },
              titleButton: 'Tambahkan Ke Keranjang',
            ),
          ],
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}

class UpdateCard extends StatelessWidget {
  final BeritaAttributes data;
  const UpdateCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/berita/${data.slug}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.width * 0.22,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                image: DecorationImage(
                  image: NetworkImage(
                      '${Constant.host}${data.gambar!.data!.attributes!.url}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 18,
                ),
                child: Text(
                  data.judul!.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    fontSize: 18,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemLayananCardList extends StatefulWidget {
  final Layanan data;
  final int id;
  const ItemLayananCardList({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  State<ItemLayananCardList> createState() => _ItemLayananCardListState();
}

class _ItemLayananCardListState extends State<ItemLayananCardList> {
  Map<String, dynamic> user = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    context.read<WilayahController>().getAllDataProvinces();
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${Constant.host}${widget.data.attributes!.gambar!.data!.attributes!.url}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButtonHovered(
                      onTap: () {
                        context.go(
                            '/layanan/detail/${widget.data.attributes!.slug}');
                      },
                      text: widget.data.attributes!.judul.toString(),
                      styleBeforeHovered: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                      styleHovered: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppMethods.currency(
                              widget.data.attributes!.harga.toString()),
                          style: AppTheme.primaryTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.data.attributes!.satuan != null
                              ? widget.data.attributes!.satuan.toString()
                              : '/ hari',
                          style: AppTheme.greyTextStyle.copyWith(
                            fontWeight: AppTheme.medium,
                            fontSize: 18,
                            color: AppColors.softgreyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.data.attributes!.intro.toString(),
                      style: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.medium,
                        height: 1.5,
                      ),
                    ),
                    PrimaryButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: ModalInformationCart(
                                  context,
                                  widget.data.attributes!,
                                  widget.id.toString()),
                            );
                          },
                        );
                      },
                      titleButton: 'TAMBAH KE KERANJANG',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget ModalInformationCart(
      BuildContext context, dynamic data, String idProduct) {
    final controller = context.watch<CartController>();
    final wilayahController = context.watch<WilayahController>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(35),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${Constant.host}${data.gambar?.data?.attributes?.url.toString()}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.judul.toString(),
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data.intro.toString(),
                        style: AppTheme.greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: AppTheme.medium,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.remover();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                ),
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: AppColors.primaryColor,
                                size: 19,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.blue.withOpacity(0.1),
                            child: Text(
                              controller.itemsCount.toString(),
                              style: AppTheme.blackTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: AppTheme.medium,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.add();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Harga', style: AppTheme.blackTextStyle),
                          Text(
                            AppMethods.currency(
                                controller.total(data.harga).toString()),
                            style: AppTheme.primaryTextStyle.copyWith(
                                fontWeight: AppTheme.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 10,
            ),
            // START PROVINSI
            DropdownButtonFormField<String>(
              value: wilayahController.selectedProvince,
              onChanged: (String? value) {
                setState(() {
                  wilayahController.setSelectedProvince(value);
                  wilayahController.setSelectedCity(null);
                  wilayahController.setSelectedDistrict(null);
                });
                if (wilayahController.selectedProvince!.isNotEmpty) {
                  wilayahController
                      .getAllDataCities(wilayahController.selectedProvince!);
                }
              },
              decoration: InputDecoration(
                hintStyle: AppTheme.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.greyColor, width: 2),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              items: wilayahController.provinces.map((data) {
                return DropdownMenuItem<String>(
                  value: data.attributes!.namaProvinsi,
                  child: Text(data.attributes!.namaProvinsi.toString()),
                );
              }).toList(),
              hint: Text('Pilih Provinsi', style: AppTheme.greyTextStyle),
            ),
            // END PROVINSI
            const SizedBox(
              height: 10,
            ),
            // START OF KOTAS
            DropdownButtonFormField<String>(
              value: wilayahController.selectedCity,
              onChanged: (String? value) {
                setState(() {
                  wilayahController.setSelectedCity(value);
                  wilayahController.setSelectedDistrict(null);
                });
                if (wilayahController.selectedCity!.isNotEmpty) {
                  wilayahController
                      .getAllDataKecamatan(wilayahController.selectedCity!);
                }
              },
              decoration: InputDecoration(
                hintStyle: AppTheme.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.greyColor, width: 2),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              items: wilayahController
                  .getCitiesByProvince(wilayahController.selectedProvince ?? "")
                  .map((city) {
                return DropdownMenuItem<String>(
                  value: city.attributes!.namaKota,
                  child: Text(city.attributes!.namaKota.toString()),
                );
              }).toList(),
              hint: Text('Pilih Kota', style: AppTheme.greyTextStyle),
            ),
            // END OF KOTAS
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 12,
            ),
            PrimaryButton(
              onTap: () {
                if (user['token'] == null &&
                    user['email'] == null &&
                    user['id'] == null) {
                  AppMethods.coolAlertDanger(context,
                      'Maaf, kamu harus login atau daftar terlebih dahulu');
                  context.go('/register');
                } else {
                  final productItem = {
                    'user': user,
                    'product': {
                      'id': idProduct,
                      'judul': data.judul,
                      'harga': data.harga,
                      'satuan': data.satuan,
                      'gambar': data.gambar?.data?.attributes?.url,
                    },
                    'provinsi': wilayahController.selectedProvince,
                    'kota': wilayahController.selectedCity,
                    'item': controller.itemsCount.toString(),
                    'totalHarga': controller.totalHarga.toString(),
                  };
                  controller.addToCart(productItem);
                  CoolAlert.show(
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.3,
                    type: CoolAlertType.success,
                    text: 'Product berhasil ditambahkan kedalam keranjang',
                  );
                  wilayahController.setSelectedProvince(null);
                  wilayahController.setSelectedCity(null);
                }
              },
              titleButton: 'Tambahkan Ke Keranjang',
            ),
          ],
        ),
      ),
    );
  }
}
