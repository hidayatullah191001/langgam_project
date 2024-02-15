part of 'widgets.dart';

class Navbar extends StatefulWidget {
  bool? isMobile;
  Navbar({Key? key, this.isMobile = false}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Map<String, dynamic> user = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataUser();
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
    final controller = context.watch<NavbarController>();
    final cartController = context.watch<CartController>();
    final searchController = context.watch<PencarianController>();

    return Container(
      width: double.infinity,
      height: 101,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: widget.isMobile!
            ? const EdgeInsets.symmetric(horizontal: 20)
            : const EdgeInsets.symmetric(horizontal: 150),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                // Navigator.pushReplacementNamed(context, '/');
                context.pushReplacement('/');
              },
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/logo.png',
                        ),
                      ),
                    ),
                  ),
                  !widget.isMobile!
                      ? SizedBox(
                          width: 24,
                        )
                      : Container(),
                  !widget.isMobile!
                      ? Text(
                          'LANGGAM',
                          style: AppTheme.greyTextStyle.copyWith(
                              fontSize: 18, fontWeight: AppTheme.bold),
                        )
                      : Container(),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: TextFormField(
                  onChanged: (value) {
                    searchController.setValueSearch(value);
                    if (value.length > 0) {
                      searchController.setSearchBoolean(true);
                    } else {
                      searchController.setSearchBoolean(false);
                      searchController.setValueSearch('');
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari produk',
                    hintStyle: AppTheme.greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                    suffixIcon: searchController.isSearchBoolean
                        ? InkWell(
                            onTap: () {
                              searchController.setSearchBoolean(false);
                              searchController.setValueSearch('');
                            },
                            child: const Icon(
                              Icons.highlight_remove_rounded,
                              color: AppColors.blackColor,
                            ),
                          )
                        : const Icon(
                            Icons.search_rounded,
                            color: AppColors.blackColor,
                          ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffe4e4e4),
                        width: 10,
                        strokeAlign: 20,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            !widget.isMobile!
                ? Row(
                    children: [
                      ItemNavBar(
                        title: 'LAYANAN',
                        onHover: (event) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                alignment: const Alignment(0.63, -0.55),
                                child: ModalLayanan(context),
                              );
                            },
                          );
                        },
                      ),
                      Container(
                        width: 1,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xffe4e4e4),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go('/berita');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                'BERITA',
                                style: AppTheme.secondaryTextStyle.copyWith(
                                  fontWeight: AppTheme.semiBold,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xffe4e4e4),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xffe4e4e4),
                        ),
                      ),
                      ItemNavBar(
                        title: 'BANTUAN',
                        onHover: (event) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                alignment: const Alignment(0.8, -0.55),
                                child: ModalBantuan(context),
                              );
                            },
                          );
                        },
                      ),
                      Container(
                        width: 1,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xffe4e4e4),
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 20,
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 8,
                              child: Text(
                                cartController.carts
                                    .where((cart) =>
                                        cart['user']['id'] == user['id'] &&
                                        cart['user']['email'] == user['email'])
                                    .length
                                    .toString(),
                                style: AppTheme.whiteTextStyle
                                    .copyWith(fontSize: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Scaffold.of(context).openEndDrawer();
                              // controller.pickDrawer('Cart');
                              context.go('/cart');
                              // Navigator.pushNamed(context, '/cart');
                            },
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Container(),
            widget.isMobile!
                ? Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 20,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          radius: 8,
                          child: Text(
                            cartController.carts
                                .where((cart) =>
                                    cart['user']['id'] == user['id'] &&
                                    cart['user']['email'] == user['email'])
                                .length
                                .toString(),
                            style:
                                AppTheme.whiteTextStyle.copyWith(fontSize: 10),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Scaffold.of(context).openEndDrawer();
                          // controller.pickDrawer('Cart');
                          context.go('/cart');
                          // Navigator.pushNamed(context, '/cart');
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget ModalBantuan(BuildContext context) {
    return Container(
      width: 100,
      height: 250,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BANTUAN',
                style: AppTheme.blackTextStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: AppTheme.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: BantuanService.getAllBantuan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                List<BantuanData> data = snapshot.data!.data!;

                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final BantuanAttributes bantuan = data[index].attributes!;
                      return TextButtonHovered(
                        text: bantuan.judul.toString(),
                        onTap: () {
                          context.go('/bantuan/${bantuan.slug}');
                        },
                        styleBeforeHovered: AppTheme.greyTextStyle,
                        styleHovered: AppTheme.primaryTextStyle.copyWith(
                          fontWeight: AppTheme.bold,
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget ModalUpdate(BuildContext context) {
    return Container(
      width: 100,
      height: 170,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UPDATE',
                style: AppTheme.blackTextStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: AppTheme.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          TextButtonHovered(
            text: 'Peringatan Dini Cuaca',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Gempa Bumi Terkini',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
          TextButtonHovered(
            text: 'Peringatan Dini Cuaca',
            onTap: () {},
            styleBeforeHovered: AppTheme.greyTextStyle,
            styleHovered: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget ModalLayanan(BuildContext context) {
    return Container(
      width: 100,
      height: 230,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LAYANAN',
                style: AppTheme.blackTextStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: AppTheme.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          FutureBuilder(
            future: LayananServices.getAllBidangLayanans(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final List data = snapshot.data as List;
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ItemNavBarDropDown(
                      text: data[index].attributes.judul.toString(),
                      onTap: () {
                        context.go('/layanan/${data[index].attributes.slug}');
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
          // ItemNavBarDropDown(
          //   text: 'Informasi Meteorologi',
          //   onTap: () {},
          //   lottieJson: 'lottie/animate-2.json',
          // ),
          // ItemNavBarDropDown(
          //   text: 'Informasi Klimatologi',
          //   onTap: () {},
          //   lottieJson: 'lottie/animate-4.json',
          // ),
          // ItemNavBarDropDown(
          //   text: 'Informasi Geofisika',
          //   onTap: () {},
          //   lottieJson: 'lottie/animate-3.json',
          // ),
          // ItemNavBarDropDown(
          //   text: 'Jasa Konsultasi',
          //   onTap: () {},
          //   lottieJson: 'lottie/animate-1.json',
          // ),
        ],
      ),
    );
  }
}

class ItemNavBar extends StatelessWidget {
  final String title;

  final void Function(PointerEnterEvent event) onHover;
  const ItemNavBar({
    super.key,
    required this.title,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      hoverChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Text(
              title,
              style: AppTheme.secondaryTextStyle.copyWith(
                fontWeight: AppTheme.semiBold,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xffe4e4e4),
              size: 16,
            ),
          ],
        ),
      ),
      onHover: onHover,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Text(
              title,
              style: AppTheme.secondaryTextStyle.copyWith(
                fontWeight: AppTheme.semiBold,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xffe4e4e4),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemNavBarDropDown extends StatefulWidget {
  int? index;
  final String text;
  final VoidCallback onTap;
  TextStyle? styleHovered;
  TextStyle? styleBeforeHovered;
  String? lottieJson;
  ItemNavBarDropDown({
    super.key,
    this.index = 0,
    required this.text,
    required this.onTap,
    this.styleHovered,
    this.styleBeforeHovered,
    this.lottieJson,
  });

  @override
  State<ItemNavBarDropDown> createState() => _ItemNavBarDropDownState();
}

class _ItemNavBarDropDownState extends State<ItemNavBarDropDown> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Row(
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: isHovered
                  ? AppTheme.primaryTextStyle
                      .copyWith(fontWeight: AppTheme.bold)
                  : AppTheme.greyTextStyle,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Text(widget.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
