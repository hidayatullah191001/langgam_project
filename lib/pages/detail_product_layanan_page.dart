part of 'pages.dart';

class DetailProductLayananPage extends StatefulWidget {
  final String slug;
  final String id;
  const DetailProductLayananPage({
    Key? key,
    required this.slug,
    required this.id,
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
    context.read<LayananController>().getLayananById(widget.id);
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    print('data = $data');
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layananController = context.watch<LayananController>();
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
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
          if (layananController.layanan == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const BannerTop(),
                  ]),
                ),
                const SliverAppBar(
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
                      ContentSection(),
                      const Footer(),
                    ],
                  ),
                ),
              ],
            );
          }
        }
      }),
      endDrawer: const LoginDrawer(),
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
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
                    Navigator.pushNamed(context,
                        '/layanan?bidang_layanan=${controller.layanan!.attributes!.bidangLayanan!.attributes!.slug!}');
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
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {},
                              titleButton: 'PESAN SEKARANG',
                            ),
                          ),
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
          Divider(),
          UlasanSection(),
          Divider(),
          ProdukTerkaitSection(),
        ],
      ),
    );
  }

  Widget ModalInformationLocation(BuildContext context) {
    final controller = context.watch<CartController>();
    final wilayahController = context.watch<WilayahController>();
    final layananController = context.watch<LayananController>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
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
                print(controller.carts);
              },
              titleButton: 'Tambahkan Ke Keranjang',
            ),
          ],
        ),
      ),
    );
  }

  Widget ProdukTerkaitSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50.0),
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
            // height: MediaQuery.of(context).size.height * 0.5,
            height: 300,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.19,
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
                          image: const DecorationImage(
                            image: AssetImage('images/product-1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Informasi Data Cuaca Untuk Pelbuhan',
                        style: AppTheme.blackTextStyle
                            .copyWith(fontWeight: AppTheme.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Rp 225.000',
                              style: AppTheme.primaryTextStyle.copyWith(
                                fontWeight: AppTheme.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '/ lokasi / hari',
                              style: AppTheme.greyTextStyle,
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Expanded(
                        child: PrimaryButton(
                          onTap: () {},
                          titleButton: 'TAMBAHKAN KE KERANJANG',
                        ),
                      ),
                    ],
                  ),
                );
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

  Widget ContentDeskripsi() {
    final controller = context.watch<LayananController>();
    return Container(
      padding: const EdgeInsets.only(
        left: 150.0,
        right: 150.0,
        bottom: 50.0,
      ),
      child: ListView.builder(
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
      ),
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

  Widget ContentSyaratKetentuan() {
    return Container(
      padding: const EdgeInsets.only(
        left: 150.0,
        right: 150.0,
        bottom: 50.0,
      ),
      child: Row(
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
      ),
    );
  }
}
