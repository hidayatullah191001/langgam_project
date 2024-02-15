part of 'pages.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic> user = {};
  bool isDataCartLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.watch<CartController>().getDataCart();
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

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      if (constraints.maxWidth < 1200) {
        return MobileView(searchController, context);
      } else {
        return WebView(searchController);
      }
    });
  }

  Widget MobileView(
      PencarianController searchController, BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: const BannerTopMobile(),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        actions: [
          Container(),
        ],
      ),
      body: Consumer(builder: (context, SettingController controller, widget) {
        if (controller.dataState == DataState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Navbar(
                    isMobile: true,
                  ),
                  !searchController.isSearchBoolean
                      ? defaultWidgetMobile(context)
                      : searchWidgetMobile(),
                ],
              ),
            ),
          );
        }
      }),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget WebView(PencarianController searchController) {
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
          SliverList(
            delegate: SliverChildListDelegate([
              !searchController.isSearchBoolean
                  ? defaultWidget(context)
                  : searchWidget(context),
            ]),
          ),
        ],
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget defaultWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSectionCart(
          heroPosition: 'KERANJANG BELANJA',
        ),
        ContentSection(),
        const Footer(),
      ],
    );
  }

  Widget defaultWidgetMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSectionCartMobile(
          heroPosition: 'KERANJANG BELANJA',
        ),
        ContentSectionMobile(),
        const FooterMobile(),
      ],
    );
  }

  Widget searchWidget(BuildContext context) {
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

                  print(layanan.attributes!.judul);
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
    final cartController = context.watch<CartController>();
    final carts = cartController.carts
        .where((cart) =>
            cart['user']['id'] == user['id'] &&
            cart['user']['email'] == user['email'])
        .toList();
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(
        horizontal: 150,
        vertical: 50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          carts.length == 0
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'lottie/empty_cart.json',
                          width: 150,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Keranjang kamu masih kosong',
                          style: AppTheme.greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        PrimaryButton(
                          onTap: () {
                            context.go('/layanan');
                          },
                          titleButton: 'LIHAT SEMUA LAYANAN',
                        )
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 120,
                          ),
                          Text(
                            'PRODUK',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 140,
                          ),
                          Text(
                            'HARGA',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Text(
                            'JUMLAH',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            'SUBTOTAL',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: carts.length,
                        itemBuilder: (context, index) {
                          final productCart = carts[index];
                          return ItemCartProduct(context,
                              data: productCart, index: index);
                        },
                      ),
                      const Divider(),
                    ],
                  ),
                ),
          const SizedBox(width: 30),
          Container(
            width: 300,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.softgreyColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL KERANJANG BELANJA',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          Text(
                            AppMethods.currency(
                              cartController.getTotalHargaAllItem().toString(),
                            ),
                            style: AppTheme.greyTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
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
                        AppMethods.currency(
                          cartController.getTotalHargaAllItem().toString(),
                        ),
                        style: AppTheme.primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onTap: () {
                      if (user['token'] == null &&
                          user['email'] == null &&
                          user['id'] == null) {
                        CoolAlert.show(
                          context: context,
                          width: MediaQuery.of(context).size.width * 0.3,
                          type: CoolAlertType.error,
                          text:
                              'Maaf, kamu harus login atau daftar terlebih dahulu',
                        ).then((value) => context.go('/register'));
                      } else {
                        if (cartController.carts.length > 0) {
                          context.go('/cart/checkout');
                        } else {
                          AppMethods.coolAlertDanger(context,
                              'Keranjang kamu masih kosong, pilih layanan dahulu');
                        }
                      }
                    },
                    titleButton: 'LANJUTKAN KE CHECKOUT',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ContentSectionMobile() {
    final cartController = context.watch<CartController>();
    final carts = cartController.carts
        .where((cart) =>
            cart['user']['id'] == user['id'] &&
            cart['user']['email'] == user['email'])
        .toList();
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carts.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'lottie/empty_cart.json',
                        width: 150,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Keranjang kamu masih kosong',
                        style: AppTheme.greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      PrimaryButton(
                        onTap: () {
                          context.go('/layanan');
                        },
                        titleButton: 'LIHAT SEMUA LAYANAN',
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final productCart = carts[index];
                        return ItemCartProductMobile(context,
                            data: productCart, index: index);
                      },
                    ),
                    const Divider(),
                  ],
                ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.softgreyColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL KERANJANG BELANJA',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          Text(
                            AppMethods.currency(
                              cartController.getTotalHargaAllItem().toString(),
                            ),
                            style: AppTheme.greyTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
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
                        AppMethods.currency(
                          cartController.getTotalHargaAllItem().toString(),
                        ),
                        style: AppTheme.primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onTap: () {
                      if (user['token'] == null &&
                          user['email'] == null &&
                          user['id'] == null) {
                        CoolAlert.show(
                          context: context,
                          width: MediaQuery.of(context).size.width * 0.3,
                          type: CoolAlertType.error,
                          text:
                              'Maaf, kamu harus login atau daftar terlebih dahulu',
                        ).then((value) => context.go('/register'));
                      } else {
                        if (cartController.carts.length > 0) {
                          context.go('/cart/checkout');
                        } else {
                          AppMethods.coolAlertDanger(context,
                              'Keranjang kamu masih kosong, pilih layanan dahulu');
                        }
                      }
                    },
                    titleButton: 'LANJUTKAN KE CHECKOUT',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ItemCartProduct(BuildContext context,
      {required dynamic data, required int index}) {
    final cartController = context.watch<CartController>();
    cartController.setItemsCount(int.parse(data['item']));
    cartController.setTotalHarga(int.parse(data['totalHarga']));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                cartController.removeCart(index);
              },
              child: const Icon(
                Icons.close,
                color: AppColors.greyColor,
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      '${Constant.host}${data['product']["gambar"]}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 170,
              child: Expanded(
                child: Text(
                  data['product']['judul'].toString(),
                  style: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.bold, fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 90,
                child: Column(
                  children: [
                    Text(
                      AppMethods.currency(data['product']['harga'].toString()),
                      style: AppTheme.greyTextStyle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data['product']['satuan'].toString(),
                      style: AppTheme.greyTextStyle.copyWith(
                          color: AppColors.softgreyColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (cartController.itemsCount == 1) {
                        cartController.removeCart(index);
                      } else {
                        cartController.removerinCartPage(index);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
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
                        size: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.blue.withOpacity(0.1),
                    child: Text(
                      cartController.itemsCount.toString(),
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: AppTheme.medium,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartController.addinCartPage(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
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
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Text(
              AppMethods.currency(cartController.totalHarga.toString()),
              style: AppTheme.primaryTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ItemCartProductMobile(BuildContext context,
      {required dynamic data, required int index}) {
    final cartController = context.watch<CartController>();
    cartController.setItemsCount(int.parse(data['item']));
    cartController.setTotalHarga(int.parse(data['totalHarga']));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
      child: Row(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  cartController.removeCart(index);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.greyColor,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        '${Constant.host}${data['product']["gambar"]}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['product']['judul'].toString(),
                  style: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.bold, fontSize: 14),
                ),
                Column(
                  children: [
                    Text(
                      AppMethods.currency(data['product']['harga'].toString()),
                      style: AppTheme.greyTextStyle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data['product']['satuan'].toString(),
                      style: AppTheme.greyTextStyle.copyWith(
                          color: AppColors.softgreyColor, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (cartController.itemsCount == 1) {
                          cartController.removeCart(index);
                        } else {
                          cartController.removerinCartPage(index);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
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
                          size: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.blue.withOpacity(0.1),
                      child: Text(
                        cartController.itemsCount.toString(),
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: AppTheme.medium,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cartController.addinCartPage(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
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
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Text(
                  AppMethods.currency(cartController.totalHarga.toString()),
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
