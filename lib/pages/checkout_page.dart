part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Uint8List? _selectedFile;
  String? _selectedFileName;
  Map<String, dynamic> user = {};
  bool isDataCartLoaded = false;

  void pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String fileName = result.files.single.name;

      setState(() {
        _selectedFile = fileBytes;
        _selectedFileName = fileName;
      });

      // Tambahkan logika untuk upload file ke API di sini
      // uploadFileToApi(fileBytes);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WilayahController>().getAllDataProvinces();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataUser();
      loadDataCart();
    });
  }

  loadDataCart() {
    context.read<CartController>().getDataCart();
    setState(() {
      isDataCartLoaded = true;
    });
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchController = context.watch<PencarianController>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 1200) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('lottie/maintenance.json'),
                      Text(
                        'Saat ini hanya tersedia untuk Website. Gunakan laptop untuk membuka',
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    !searchController.isSearchBoolean
                        ? defaultWidget()
                        : searchWidget(),
                  ]),
                ),
              ],
            );
          }
        },
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget defaultWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSectionCart(
          heroPosition: 'PEMESANAN',
        ),
        ContentSection(context),
        const Footer(),
      ],
    );
  }

  Widget searchWidget() {
    final searchController = context.watch<PencarianController>();
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 150.0,
      ),
      child: FutureBuilder(
        future: LayananServices.getLayananByValue(searchController.value!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Data dengan kueri ${searchController.value} tidak ditemukan',
              ),
            );
          }

          if (snapshot.hasData) {
            Layanan data = snapshot.data!;
            if (data.data!.length < 1) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      'lottie/empty_cart.json',
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Data tidak ditemukan',
                      style: AppTheme.greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: data.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final LayananData layanan = data.data![index];
                return ItemLayananCardList(
                  data: layanan,
                  id: layanan.id!,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget ContentSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailTagihanContent(),
              const SizedBox(width: 60),
              DetailPesananContent(context),
            ],
          )
        ],
      ),
    );
  }

  Widget DetailPesananContent(BuildContext context) {
    final cartController = context.watch<CartController>();
    final carts = cartController.carts
        .where((cart) =>
            cart['user']['id'] == user['id'] &&
            cart['user']['email'] == user['email'])
        .toList();
    final checkoutController = context.watch<CheckoutController>();
    final wilayahController = context.watch<WilayahController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'PESANAN ANDA',
              style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softgreyColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset.fromDirection(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRODUK',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'SUBTOTAL',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    final productCart = carts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${Constant.host}${productCart['product']['gambar']}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '${productCart['product']['judul']} x ${productCart['item']}',
                                    style: AppTheme.primaryTextStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            AppMethods.currency(productCart['totalHarga'])
                                .toString(),
                            style: AppTheme.greyTextStyle,
                          ),
                        ],
                      ),
                    );
                    // return CartItemWidget(data: productCart, index: index);
                  },
                ),

                const SizedBox(height: 20),
                const Divider(),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 6,
                //         horizontal: 10,
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Subtotal',
                //             style: AppTheme.blackTextStyle.copyWith(
                //               fontWeight: AppTheme.bold,
                //             ),
                //           ),
                //           Text('Rp65.000', style: AppTheme.greyTextStyle),
                //         ],
                //       ),
                //     ),
                //     const Divider(),
                //   ],
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 6,
                //         horizontal: 10,
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             'Pajak',
                //             style: AppTheme.blackTextStyle.copyWith(
                //               fontWeight: AppTheme.bold,
                //             ),
                //           ),
                //           Text(
                //             'Rp7.150',
                //             style: AppTheme.primaryTextStyle
                //                 .copyWith(fontWeight: AppTheme.bold),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const Divider(),
                //   ],
                // ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTheme.blackTextStyle
                            .copyWith(fontWeight: AppTheme.bold, fontSize: 18),
                      ),
                      Text(
                        AppMethods.currency(cartController
                                .getTotalHargaAllItem()
                                .toString())
                            .toString(),
                        style: AppTheme.primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Bayar Setelah Disetujui',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softgreyColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset.fromDirection(0, 2),
                ),
              ],
            ),
            child: Text(
              'Harap kirimkan pembayaran setelah pesanan anda kami setujui dan melengkapi kelengkapan data sesuai instruksi kami yang akan kami kirim ke akun anda,',
              style: AppTheme.greyTextStyle.copyWith(
                height: 1.2,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () {
                checkoutController.prosesCheckout(context,
                    provinsi: wilayahController.selectedProvince.toString(),
                    kota: wilayahController.selectedCity.toString(),
                    kecamatan: wilayahController.selectedDistrict.toString(),
                    cart: carts);
              },
              titleButton: "BUAT PESANAN",
            ),
          ),
        ],
      ),
    );
  }

  Expanded DetailTagihanContent() {
    final wilayahController = context.watch<WilayahController>();
    final checkoutController = context.watch<CheckoutController>();
    final cartController = context.watch<CartController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DETAIL TAGIHAN',
            style: AppTheme.blackTextStyle.copyWith(
                fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomFormUser(
                  controller: checkoutController.namaDepanController,
                  title: 'Nama depan',
                  isMandatory: true,
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: CustomFormUser(
                  controller: checkoutController.namaBelakangController,
                  title: 'Nama belakang',
                  isMandatory: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            controller: checkoutController.namaPerusahaanController,
            title: 'Nama perusahaan',
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text('Provinsi ', style: AppTheme.blackTextStyle),
              Text(
                '*',
                style: AppTheme.blackTextStyle.copyWith(
                  color: AppColors.dangerColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
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
          ),
          // END PROVINSI
          const SizedBox(
            height: 10,
          ),
          // START OF KOTAS
          Row(
            children: [
              Text('Kota ', style: AppTheme.blackTextStyle),
              Text(
                '*',
                style: AppTheme.blackTextStyle.copyWith(
                  color: AppColors.dangerColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
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
          ),
          // END OF KOTAS
          const SizedBox(
            height: 10,
          ),
          // START DISTRICT
          Row(
            children: [
              Text('Kecamatan ', style: AppTheme.blackTextStyle),
              Text(
                '*',
                style: AppTheme.blackTextStyle.copyWith(
                  color: AppColors.dangerColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: wilayahController.selectedDistrict,
            onChanged: (String? value) {
              setState(() {
                wilayahController.setSelectedDistrict(value);
              });
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
                .getDistrictsByCity(wilayahController.selectedCity ?? "")
                .map((district) {
              return DropdownMenuItem<String>(
                value: district.attributes!.namaKecamatan,
                child: Text(district.attributes!.namaKecamatan.toString()),
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          // END KECAMATAN
          CustomFormUser(
            controller: checkoutController.alamatJalanController,
            title: 'Alamat jalan',
            isMandatory: true,
          ),
          // const SizedBox(height: 15),
          // CustomFormUser(
          //   controller: checkoutController.kodePosController,
          //   title: 'Kode pos',
          //   isMandatory: true,
          // ),
          const SizedBox(height: 15),
          CustomFormUser(
            controller: checkoutController.teleponController,
            title: 'Telepon',
            isMandatory: true,
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            controller: checkoutController.alamatEmailController,
            title: 'Alamat email',
            isMandatory: true,
          ),
          const SizedBox(height: 15),
          Text(
            'INFORMASI TAMBAHAN',
            style: AppTheme.blackTextStyle.copyWith(
                fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 15),
          // START OF KOTAS
          Row(
            children: [
              Text('Keperluan ', style: AppTheme.blackTextStyle),
              Text(
                '*',
                style: AppTheme.blackTextStyle.copyWith(
                  color: AppColors.dangerColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: checkoutController.selectedKeperluan,
            onChanged: (String? value) {
              setState(() {
                checkoutController.setSelectedKeperluan(value!);
              });
              if (checkoutController.selectedKeperluan == 'Penelitian' ||
                  checkoutController.selectedKeperluan == 'Riset') {
                cartController.setItemToFree();
              } else if (checkoutController.selectedKeperluan == 'Komersial') {
                cartController.setItemToKomersial();
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
            items: checkoutController.keperluans.map((keperluan) {
              return DropdownMenuItem<String>(
                value: keperluan,
                child: Text(keperluan.toString()),
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            controller: checkoutController.catatanPesananController,
            title: 'Catatan Pesananan',
            minLines: 5,
            maxLines: 7,
          ),
        ],
      ),
    );
  }
}
