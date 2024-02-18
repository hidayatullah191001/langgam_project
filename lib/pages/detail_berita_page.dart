part of 'pages.dart';

class DetailBeritaPage extends StatefulWidget {
  final String slug;
  const DetailBeritaPage({Key? key, required this.slug}) : super(key: key);

  @override
  State<DetailBeritaPage> createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BeritaController>().getBeritaBySlug(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
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
                      ? defaultWidgetMobile()
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

  Widget webView() {
    final controller = context.watch<NavbarController>();
    final searchController = context.watch<PencarianController>();

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
                  ? defaultWidget()
                  : searchWidget(),
            ]),
          ),
        ],
      ),
      endDrawer: controller.selectedDrawer == 'Login'
          ? const LoginDrawer()
          : Container(),
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

  Widget ContentSection() {
    return FutureBuilder(
      future: BeritaService.getBeritaBySlug(widget.slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 200,
            margin: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: Center(
              child: Text('Tidak bisa mengambil data, coba lagi'),
            ),
          );
        }

        if (snapshot.hasData) {
          final berita = snapshot.data!.data![0].attributes;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  berita!.judul.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              berita.gambar!.data != null
                  ? Image.network(
                      '${Constant.host}${berita.gambar!.data!.attributes!.url}',
                    )
                  : Container(),
              const SizedBox(height: 20),
              JsonTextWidget(
                jsonData: berita.konten!,
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
      future: BeritaService.getBeritaBySlug(widget.slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 200,
            margin: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: const Center(
              child: Text('Tidak bisa mengambil data, coba lagi'),
            ),
          );
        }

        if (snapshot.hasData) {
          final berita = snapshot.data!.data![0].attributes;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  berita!.judul.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              berita.gambar!.data != null
                  ? Image.network(
                      '${Constant.host}${berita.gambar!.data!.attributes!.url}',
                    )
                  : Container(),
              const SizedBox(height: 20),
              JsonTextWidget(
                jsonData: berita.konten!,
              ),
            ]),
          );
        }
        return Container();
      },
    );
  }
}

class JsonTextWidget extends StatelessWidget {
  final List<Konten> jsonData;

  JsonTextWidget({required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: jsonData.length,
      itemBuilder: (context, index) {
        final item = jsonData[index];

        if (item.type == 'heading') {
          return Text(
            item.children![0].text!,
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 24, fontWeight: AppTheme.bold),
          );
        } else if (item.type == 'paragraph') {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              item.children![0].text!,
              style: AppTheme.greyTextStyle,
            ),
          );
        }
      },
    );
  }
}
