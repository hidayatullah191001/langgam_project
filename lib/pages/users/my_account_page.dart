part of '../pages.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    final searchController = context.watch<PencarianController>();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1200) {
        return mobileView(searchController, context);
      } else {}
      return webView(searchController);
    });
  }

  Widget mobileView(
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
                  ? defaultWidgetMobile(context)
                  : searchWidgetMobile(),
            ],
          ),
        ),
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget webView(PencarianController searchController) {
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
            actions: const [SizedBox()],
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
        HeroSection(
          heroTitle: 'AKUN SAYA',
          heroPosition: 'RUMAH  ',
        ),
        myAccountSection(context),
        const Footer(),
      ],
    );
  }

  Widget defaultWidgetMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSection(
          heroTitle: 'AKUN SAYA',
          heroPosition: 'RUMAH  ',
        ),
        myAccountSectionMobile(context),
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
            if (data.data!.isEmpty) {
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
      padding: const EdgeInsets.symmetric(
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

  Widget myAccountSection(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    final authController = context.watch<AuthController>();
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AKUN SAYA',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuUser.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.pickMenu(menuUser[index], index);
                        if (menuUser[index] == 'Logout') {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              width: MediaQuery.of(context).size.width * 0.3,
                              confirmBtnText: 'Logout',
                              confirmBtnColor: AppColors.dangerColor,
                              cancelBtnText: 'Batal',
                              confirmBtnTextStyle: AppTheme.whiteTextStyle,
                              cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
                              text: 'Kamu yakin ingin keluar dari aplikasi?',
                              showCancelBtn: true,
                              onConfirmBtnTap: () {
                                authController.logout();
                                context.replace('/');
                                context.pop();
                              },
                              onCancelBtnTap: () {
                                context.pop();
                              }).then((value) => context.pop());
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: controller.selectedIndex == index
                              ? AppColors.backgroundColor2
                              : Colors.transparent,
                        ),
                        child: Text(
                          menuUser[index],
                          style: AppTheme.blackTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: 2,
            height: MediaQuery.of(context).size.height * 0.5,
            color: AppColors.softgreyColor.withOpacity(0.2),
          ),
          buildConditionalWidget(
              controller.selectedMenu == 'Dasbor', const DashboardSection()),
          buildConditionalWidget(
              controller.selectedMenu == 'Pesanan', const PesananSection()),
          // buildConditionalWidget(
          //     controller.selectedMenu == 'Messages', const MessageSection()),
          buildConditionalWidget(
              controller.selectedMenu == 'Unduhan', const DownloadSection()),
          buildConditionalWidget(
              controller.selectedMenu == 'Alamat', const AddressSection()),
          buildConditionalWidget(controller.selectedMenu == 'Detail Akun',
              const AccountSettingsSection()),
          // buildConditionalWidget(controller.selectedMenu == 'Attachments',
          //     const AttachmentSection()),

          // Ini ada di halaman address_section.dart
          buildConditionalWidget(controller.selectedMenu == 'Alamat pengiriman',
              const AlamatPengirimanSection()),
          buildConditionalWidget(controller.selectedMenu == 'Alamat penagihan',
              const AlamatPenagihanSection()),

          // Ini ada di halaman pesanan_section.dart
          buildConditionalWidget(controller.selectedMenu == 'Detail pesanan',
              const DetailPesananSection()),
        ],
      ),
    );
  }

  Widget myAccountSectionMobile(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    final authController = context.watch<AuthController>();
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AKUN SAYA',
                style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: menuUser.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.pickMenu(menuUser[index], index);
                        if (menuUser[index] == 'Logout') {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              width: MediaQuery.of(context).size.width * 0.3,
                              confirmBtnText: 'Logout',
                              confirmBtnColor: AppColors.dangerColor,
                              cancelBtnText: 'Batal',
                              confirmBtnTextStyle: AppTheme.whiteTextStyle,
                              cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
                              text: 'Kamu yakin ingin keluar dari aplikasi?',
                              showCancelBtn: true,
                              onConfirmBtnTap: () {
                                authController.logout();
                                context.replace('/');
                                context.pop();
                              },
                              onCancelBtnTap: () {
                                context.pop();
                              }).then((value) => context.pop());
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: controller.selectedIndex == index
                              ? AppColors.backgroundColor2
                              : Colors.transparent,
                        ),
                        child: Text(
                          menuUser[index],
                          style: AppTheme.blackTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 1,
            color: AppColors.softgreyColor.withOpacity(0.2),
          ),
          const SizedBox(height: 20),
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Dasbor', const DashboardSection()),
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Pesanan', const PesananSection()),
          // buildConditionalWidgetMobile(
          //     controller.selectedMenu == 'Messages', const MessageSection()),
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Unduhan', const DownloadSection()),
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Alamat', const AddressSection()),
          buildConditionalWidgetMobile(controller.selectedMenu == 'Detail Akun',
              const AccountSettingsSection()),
          // buildConditionalWidgetMobile(controller.selectedMenu == 'Attachments',
          //     const AttachmentSection()),

          // Ini ada di halaman address_section.dart
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Alamat pengiriman',
              const AlamatPengirimanSection()),
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Alamat penagihan',
              const AlamatPenagihanSection()),

          // Ini ada di halaman pesanan_section.dart
          buildConditionalWidgetMobile(
              controller.selectedMenu == 'Detail pesanan',
              const DetailPesananSection()),
        ],
      ),
    );
  }

  Widget buildConditionalWidget(dynamic condition, Widget widget) {
    return condition
        ? Expanded(
            child: widget,
          )
        : Container();
  }

  Widget buildConditionalWidgetMobile(dynamic condition, Widget widget) {
    return condition ? widget : Container();
  }
}
