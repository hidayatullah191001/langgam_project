part of 'pages.dart';

class DetailProductLayananPage extends StatefulWidget {
  final String slug;
  const DetailProductLayananPage({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  State<DetailProductLayananPage> createState() =>
      _DetailProductLayananPageState();
}

class _DetailProductLayananPageState extends State<DetailProductLayananPage> {
  String stateDesk = 'DESKRIPSI';
  Map<String, dynamic> user = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    context.read<WilayahController>().getAllDataProvinces();
    context.read<LayananController>().getLayananBySlug(widget.slug);
    context.read<SettingController>().getSettingWeb();
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layananController = context.watch<LayananController>();
    final searchController = context.watch<PencarianController>();

    return Consumer(
      builder: (context, SettingController controller, widget) {
        if (controller.dataState == DataState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 1200) {
              return MobileView(searchController, context);
            } else {
              return WebView(layananController, searchController);
            }
          },
        );
      },
    );
  }

  Widget MobileView(
      PencarianController searchController, BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: BannerTopMobile(),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        actions: [
          new Container(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Navbar(
                isMobile: true,
              ),
              !searchController.isSearchBoolean
                  ? defaultWidgetMobile()
                  : searchWidgetMobile(),
            ],
          ),
        ),
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget WebView(LayananController layananController,
      PencarianController searchController) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const BannerTop(),
            ]),
          ),
          SliverAppBar(
            pinned: true,
            floating: false,
            collapsedHeight: 101.0,
            automaticallyImplyLeading: false,
            flexibleSpace: Navbar(),
            actions: [SizedBox()],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                !searchController.isSearchBoolean
                    ? defaultWidget()
                    : searchWidget(),
              ],
            ),
          ),
        ],
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget defaultWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentSection(),
        const Footer(),
      ],
    );
  }

  Widget defaultWidgetMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentSectionMobile(),
        const FooterMobile(),
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

  Widget searchWidgetMobile() {
    final searchController = context.watch<PencarianController>();
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
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
                    const SizedBox(height: 20),
                    PrimaryButton(
                      onTap: () {
                        searchController.setSearchBoolean(false);
                      },
                      titleButton: "KEMBALI",
                    )
                  ],
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: data.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final LayananData layanan = data.data![index];
                  return ItemLayananCardList(
                    data: layanan,
                    id: layanan.id!,
                    isMobile: true,
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget ContentSection() {
    final controller = context.watch<LayananController>();
    final cartController = context.watch<CartController>();
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 150,
              right: 150,
              top: 15,
            ),
            child: Row(
              children: [
                TextButtonHovered(
                  text: 'Beranda',
                  onTap: () {
                    context.go('/');
                  },
                  styleBeforeHovered: AppTheme.greyTextStyle,
                  styleHovered: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.semiBold),
                ),
                Text(' / ', style: AppTheme.greyTextStyle),
                TextButtonHovered(
                  text: controller
                      .layanan!.attributes!.bidangLayanan!.attributes!.judul!,
                  onTap: () {
                    context.go(
                        '/layanan/${controller.layanan!.attributes!.bidangLayanan!.attributes!.slug!}');
                    ;
                  },
                  styleBeforeHovered: AppTheme.greyTextStyle,
                  styleHovered: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.semiBold),
                ),
                Text(' / ', style: AppTheme.greyTextStyle),
                Text(
                  controller.layanan!.attributes!.judul.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 50,
              left: 150,
              right: 150,
            ),
            child: Row(
              children: [
                Container(
                  width: 500,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${Constant.host}${controller.layanan!.attributes!.gambar!.data!.attributes!.url}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        controller.layanan!.attributes!.judul.toString(),
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 50,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppMethods.currency(cartController
                                .total(controller.layanan!.attributes!.harga!)
                                .toString()),
                            style: AppTheme.primaryTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            controller.layanan!.attributes!.satuan.toString(),
                            style: AppTheme.greyTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        controller.layanan!.attributes!.intro.toString(),
                        style: AppTheme.greyTextStyle.copyWith(
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  cartController.remover();
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
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(11),
                                color: Colors.blue.withOpacity(0.1),
                                child: Text(
                                  cartController.itemsCount.toString(),
                                  style: AppTheme.blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: AppTheme.medium,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cartController.add();
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: ModalInformationLocation(context),
                                    );
                                  },
                                );
                              },
                              titleButton: 'TAMBAH KE KERANJANG',
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Expanded(
                          //   child: PrimaryButton(
                          //     onTap: () {},
                          //     titleButton: 'PESAN SEKARANG',
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  stateDesk == 'DESKRIPSI'
                      ? Container(
                          width: 50,
                          height: 3,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox(height: 3),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButtonHovered(
                    text: 'DESKRIPSI',
                    onTap: () {
                      setState(() {
                        stateDesk = 'DESKRIPSI';
                      });
                    },
                    styleBeforeHovered: stateDesk == 'DESKRIPSI'
                        ? AppTheme.blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          )
                        : AppTheme.greyTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          ),
                    styleHovered: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  stateDesk == 'SYARAT & KETENTUAN'
                      ? Container(
                          width: 50,
                          height: 3,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox(height: 3),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButtonHovered(
                    text: 'SYARAT & KETENTUAN',
                    onTap: () {
                      setState(() {
                        stateDesk = 'SYARAT & KETENTUAN';
                      });
                    },
                    styleBeforeHovered: stateDesk == 'SYARAT & KETENTUAN'
                        ? AppTheme.blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          )
                        : AppTheme.greyTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          ),
                    styleHovered: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          stateDesk == 'DESKRIPSI'
              ? ContentDeskripsi()
              : ContentSyaratKetentuan(),
          // Divider(),
          // UlasanSection(),
          Divider(),
          ProdukTerkaitSection(),
        ],
      ),
    );
  }

  Widget ContentSectionMobile() {
    final controller = context.watch<LayananController>();
    final cartController = context.watch<CartController>();
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
            ),
            child: Row(
              children: [
                TextButtonHovered(
                  text: 'Beranda',
                  onTap: () {
                    context.go('/');
                  },
                  styleBeforeHovered: AppTheme.greyTextStyle,
                  styleHovered: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.semiBold,
                    fontSize: 14,
                  ),
                ),
                Text(' / ', style: AppTheme.greyTextStyle),
                TextButtonHovered(
                  text: controller
                      .layanan!.attributes!.bidangLayanan!.attributes!.judul!,
                  onTap: () {
                    context.go(
                        '/layanan/${controller.layanan!.attributes!.bidangLayanan!.attributes!.slug!}');
                    ;
                  },
                  styleBeforeHovered: AppTheme.greyTextStyle,
                  styleHovered: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.semiBold,
                    fontSize: 14,
                  ),
                ),
                Text(' / ', style: AppTheme.greyTextStyle),
                Expanded(
                  child: Text(
                    controller.layanan!.attributes!.judul.toString(),
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 50,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${Constant.host}${controller.layanan!.attributes!.gambar!.data!.attributes!.url}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      controller.layanan!.attributes!.judul.toString(),
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 50,
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppMethods.currency(cartController
                              .total(controller.layanan!.attributes!.harga!)
                              .toString()),
                          style: AppTheme.primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.layanan!.attributes!.satuan.toString(),
                          style: AppTheme.greyTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      controller.layanan!.attributes!.intro.toString(),
                      style: AppTheme.greyTextStyle.copyWith(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                cartController.remover();
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
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(11),
                              color: Colors.blue.withOpacity(0.1),
                              child: Text(
                                cartController.itemsCount.toString(),
                                style: AppTheme.blackTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: AppTheme.medium,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cartController.add();
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: PrimaryButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: ModalInformationLocation(context,
                                        isMobile: true),
                                  );
                                },
                              );
                            },
                            titleButton: 'TAMBAH KE KERANJANG',
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  stateDesk == 'DESKRIPSI'
                      ? Container(
                          width: 50,
                          height: 3,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox(height: 3),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButtonHovered(
                    text: 'DESKRIPSI',
                    onTap: () {
                      setState(() {
                        stateDesk = 'DESKRIPSI';
                      });
                    },
                    styleBeforeHovered: stateDesk == 'DESKRIPSI'
                        ? AppTheme.blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          )
                        : AppTheme.greyTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          ),
                    styleHovered: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  stateDesk == 'SYARAT & KETENTUAN'
                      ? Container(
                          width: 50,
                          height: 3,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox(height: 3),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButtonHovered(
                    text: 'SYARAT & KETENTUAN',
                    onTap: () {
                      setState(() {
                        stateDesk = 'SYARAT & KETENTUAN';
                      });
                    },
                    styleBeforeHovered: stateDesk == 'SYARAT & KETENTUAN'
                        ? AppTheme.blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          )
                        : AppTheme.greyTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          ),
                    styleHovered: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          stateDesk == 'DESKRIPSI'
              ? ContentDeskripsi(isMobile: true)
              : ContentSyaratKetentuan(isMobile: true),
          // Divider(),
          // UlasanSection(),
          Divider(),
          ProdukTerkaitSectionMobile(),
        ],
      ),
    );
  }

  Widget ModalInformationLocation(BuildContext context,
      {bool isMobile = false}) {
    final controller = context.watch<CartController>();
    final wilayahController = context.watch<WilayahController>();
    final layananController = context.watch<LayananController>();

    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(35),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih lokasi',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
              ),
            ),
            const SizedBox(height: 10),
            // START PROVINSI
            DropdownButtonFormField<String>(
              value: wilayahController.selectedProvince,
              onChanged: (String? value) {
                wilayahController.setSelectedProvince(value);
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
                    text: 'Maaf, kamu harus login atau daftar terlebih dahulu',
                  ).then(
                    (value) => Navigator.pushNamed(
                      context,
                      '/register',
                    ),
                  );
                } else {
                  final productItem = {
                    'user': user,
                    'product': {
                      'id': layananController.layanan!.id,
                      'judul': layananController.layanan!.attributes!.judul,
                      'harga': layananController.layanan!.attributes!.harga,
                      'satuan': layananController.layanan!.attributes!.satuan,
                      'gambar': layananController
                          .layanan!.attributes!.gambar!.data!.attributes?.url,
                    },
                    'provinsi': wilayahController.selectedProvince,
                    'kota': wilayahController.selectedCity,
                    'item': controller.itemsCount.toString(),
                    'totalHarga': controller.totalHarga.toString(),
                  };
                  controller.addToCart(productItem);
                  wilayahController.setSelectedProvince(null);
                  wilayahController.setSelectedCity(null);
                  CoolAlert.show(
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.3,
                    type: CoolAlertType.success,
                    text: 'Product berhasil ditambahkan kedalam keranjang',
                  );
                }
              },
              titleButton: 'Tambahkan Ke Keranjang',
            ),
          ],
        ),
      ),
    );
  }

  Widget ProdukTerkaitSection() {
    final controller = context.watch<LayananController>();
    final String bidangLayananId =
        controller.layanan!.attributes!.bidangLayanan!.id.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'PRODUK TERKAIT',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 30,
            height: 2,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: FutureBuilder(
              future:
                  LayananServices.getLayananByBidangLayananId(bidangLayananId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text('Data tidak ditemukan',
                        style: AppTheme.blackTextStyle),
                  );
                }

                if (snapshot.hasData) {
                  Layanan data = snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data.data!.length >= 4 ? 4 : data.data!.length,
                    itemBuilder: (context, index) {
                      final layanan = data.data![index];
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.19,
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 8,
                          right: index == 3 ? 0 : 8,
                        ),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${Constant.host}${layanan.attributes!.gambar!.data!.attributes!.url ?? ''}'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                layanan.attributes!.judul.toString(),
                                style: AppTheme.blackTextStyle
                                    .copyWith(fontWeight: AppTheme.bold),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppMethods.currency(
                                          layanan.attributes!.harga.toString()),
                                      style: AppTheme.primaryTextStyle.copyWith(
                                        fontWeight: AppTheme.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      layanan.attributes!.satuan.toString(),
                                      style: AppTheme.greyTextStyle,
                                    ),
                                  ]),
                              const SizedBox(height: 10),
                              PrimaryButton(
                                onTap: () {
                                  context.go(
                                      '/layanan/${layanan.attributes!.slug}');
                                },
                                titleButton: 'LIHAT DETAIL',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ProdukTerkaitSectionMobile() {
    final controller = context.watch<LayananController>();
    final String bidangLayananId =
        controller.layanan!.attributes!.bidangLayanan!.id.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'PRODUK TERKAIT',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 30,
            height: 2,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: FutureBuilder(
              future:
                  LayananServices.getLayananByBidangLayananId(bidangLayananId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text('Data tidak ditemukan',
                        style: AppTheme.blackTextStyle),
                  );
                }

                if (snapshot.hasData) {
                  Layanan data = snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: data.data!.length >= 3 ? 3 : data.data!.length,
                    itemBuilder: (context, index) {
                      final layanan = data.data![index];
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : 8,
                          right: index == 3 ? 0 : 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${Constant.host}${layanan.attributes!.gambar!.data!.attributes!.url ?? ''}'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              layanan.attributes!.judul.toString(),
                              style: AppTheme.blackTextStyle
                                  .copyWith(fontWeight: AppTheme.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              AppMethods.currency(
                                  layanan.attributes!.harga.toString()),
                              style: AppTheme.primaryTextStyle.copyWith(
                                fontWeight: AppTheme.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              layanan.attributes!.satuan.toString(),
                              style: AppTheme.greyTextStyle,
                            ),
                            const SizedBox(height: 10),
                            PrimaryButton(
                              onTap: () {
                                context
                                    .go('/layanan/${layanan.attributes!.slug}');
                              },
                              titleButton: 'LIHAT DETAIL',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget UlasanSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ULASAN',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ulasanUser.length,
                  itemBuilder: (context, index) {
                    final Map data = ulasanUser[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 18,
                                child: FaIcon(
                                  FontAwesomeIcons.user,
                                  color: AppColors.backgroundColor2,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['nama'],
                                    style: AppTheme.blackTextStyle
                                        .copyWith(fontWeight: AppTheme.bold),
                                  ),
                                  Text(data['email'],
                                      style: AppTheme.darkGreyTextStyle),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(data['ulasan'], style: AppTheme.greyTextStyle),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jadilah yang pertama memberikan ulasan “Informasi Data Cuaca Khusus Untuk Kegiatan Olah Raga” ',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                          'Alamat email Anda tidak akan dipublikasikan. Ruas yang wajib ditandai',
                          style: AppTheme.greyTextStyle),
                    ),
                    Text(
                      '*',
                      style: AppTheme.greyTextStyle.copyWith(
                        color: AppColors.dangerColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomFormUser(
                  title: 'Ulasan Anda',
                  isMandatory: true,
                  minLines: 6,
                  maxLines: 7,
                ),
                const SizedBox(height: 15),
                CustomFormUser(
                  title: 'Nama',
                  isMandatory: true,
                ),
                const SizedBox(height: 15),
                CustomFormUser(
                  title: 'Email',
                  isMandatory: true,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  onTap: () {},
                  titleButton: 'KIRIM',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ContentDeskripsi({bool isMobile = false}) {
    final controller = context.watch<LayananController>();
    return Container(
      padding: EdgeInsets.only(
        left: isMobile ? 20 : 150.0,
        right: isMobile ? 20 : 150.0,
        bottom: 50.0,
      ),
      child: controller.layanan!.attributes!.konten != null
          ? ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.layanan!.attributes!.konten!.length,
              itemBuilder: (context, index) {
                final konten = controller.layanan!.attributes!.konten![index];
                if (konten.type == 'heading') {
                  return Text(
                    konten.children![0].text!,
                    style: AppTheme.blackTextStyle
                        .copyWith(fontSize: 24, fontWeight: AppTheme.bold),
                  );
                } else if (konten.type == 'paragraph') {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      konten.children![0].text!,
                      style: AppTheme.greyTextStyle,
                    ),
                  );
                }
              },
            )
          : Container(),
      // child: Column(
      //   children: [
      //     Text(
      //       'Informasi cuaca memainkan peran kunci dalam kegiatan olahraga dengan berbagai manfaat, termasuk:',
      //       style: AppTheme.greyTextStyle,
      //     ),
      //   ],
      // ),
    );
  }

  Widget ContentSyaratKetentuan({bool isMobile = false}) {
    return Container(
      padding: EdgeInsets.only(
        left: isMobile ? 20 : 150.0,
        right: isMobile ? 20 : 150.0,
        bottom: 50.0,
      ),
      child: !isMobile
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('images/photo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(width: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: syaratKetentuan.map((data) {
                    final title = data['title'];
                    final items = data['items'] as List;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.blackTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ...items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.only(top: 13.0),
                                  child: const Icon(
                                    Icons.circle,
                                    size: 7,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 500,
                                  child: Text(
                                    item,
                                    style: AppTheme.greyTextStyle.copyWith(
                                      height: 2,
                                    ),
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('images/photo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: syaratKetentuan.map((data) {
                    final title = data['title'];
                    final items = data['items'] as List;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.blackTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ...items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.only(top: 13.0),
                                  child: const Icon(
                                    Icons.circle,
                                    size: 7,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    width: 500,
                                    child: Text(
                                      item,
                                      style: AppTheme.greyTextStyle.copyWith(
                                        height: 2,
                                      ),
                                      maxLines: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
    );
  }
}
