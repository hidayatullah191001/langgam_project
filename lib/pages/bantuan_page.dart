part of 'pages.dart';

class BantuanPage extends StatefulWidget {
  final String slug;
  const BantuanPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<BantuanPage> createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BantuanController>().getBantuanBySlug(widget.slug);
    context.read<SettingController>().getSettingWeb();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();
    final searchController = context.watch<PencarianController>();

    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      if (constraints.maxWidth < 800) {
        return mobileView();
      } else {
        return webView();
      }
    });
  }

  Widget mobileView() {
    final searchController = context.watch<PencarianController>();
    final settingController = context.watch<SettingController>();
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
      body: settingController.dataState == DataState.loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
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

  Widget webView() {
    final searchController = context.watch<PencarianController>();
    final settingController = context.watch<SettingController>();

    if (settingController.dataState == DataState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: CustomScrollView(
          cacheExtent: 5000,
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
  }

  Widget defaultWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentSection(),
        const Footer(),
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

  Widget defaultWidgetMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentSectionMobile(),
        const FooterMobile(),
      ],
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
    return FutureBuilder(
      future: BantuanService.getBantuanBySlug(widget.slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('Tidak bisa mengambil data, coba lagi'));
        }

        if (snapshot.hasData) {
          final bantuan = snapshot.data!.data![0].attributes;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  bantuan!.judul.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              bantuan.gambar!.data != null
                  ? Image.network(
                      '${Constant.host}${bantuan.gambar!.data!.attributes!.url}',
                    )
                  : Container(),
              const SizedBox(height: 10),
              bantuan.intro != null
                  ? Text(
                      bantuan.intro.toString(),
                      style: AppTheme.greyTextStyle,
                    )
                  : Container(),
              const SizedBox(height: 20),
              JsonTextWidget(
                jsonData: bantuan.konten!,
              ),
            ]),
          );
        }
        return Container();
      },
    );
  }

  Widget ContentSectionMobile() {
    return FutureBuilder(
      future: BantuanService.getBantuanBySlug(widget.slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('Tidak bisa mengambil data, coba lagi'));
        }

        if (snapshot.hasData) {
          final bantuan = snapshot.data!.data![0].attributes;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  bantuan!.judul.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              bantuan.gambar!.data != null
                  ? Image.network(
                      '${Constant.host}${bantuan.gambar!.data!.attributes!.url}',
                    )
                  : Container(),
              const SizedBox(height: 10),
              bantuan.intro != null
                  ? Text(
                      bantuan.intro.toString(),
                      style: AppTheme.greyTextStyle,
                    )
                  : Container(),
              const SizedBox(height: 20),
              JsonTextWidget(
                jsonData: bantuan.konten!,
              ),
            ]),
          );
        }
        return Container();
      },
    );
  }
}
