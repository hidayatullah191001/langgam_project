part of 'pages.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  var isHovered = false;
  ScrollController _scrollController = ScrollController();
  bool webView = true;
  bool webViewJs = true;

  @override
  void initState() {
    super.initState();
    context.read<SettingController>().getSettingWeb();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1200) {
          return MobileView(context);
        } else {
          return WebView();
        }
      },
    );
  }

  Widget MobileView(BuildContext context) {
    final searchController = context.watch<PencarianController>();
    final settingController = context.watch<SettingController>();

    if (settingController.dataState == DataState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: const BannerTopMobile(),
          backgroundColor: AppColors.primaryColor,
          actions: [
            Container(),
          ],
          automaticallyImplyLeading: false,
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
  }

  Widget WebView() {
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
                    ? defaultWidget()
                    : searchWidget(),
              ]),
            ),
          ],
        ),
        endDrawer: const LoginDrawer(),
      );
    }
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

  Widget defaultWidgetMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpeningSectionMobile(context),
        LayananBMKGSectionMobile(),
        LayananPopulerSectionMobile(),
        const FooterMobile(),
      ],
    );
  }

  Widget defaultWidget({bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpeningSection(context),
        LayananBMKGSection(),
        LayananPopulerSection(),
        const Footer(),
      ],
    );
  }

  Widget UpdateSection() {
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
        child: Column(
          children: [
            Text(
              'Update Terkini',
              style: AppTheme.blackTextStyle.copyWith(
                fontSize: 56,
                fontWeight: AppTheme.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Akses informasi terkini beragam kejadian cuaca, iklim dan gempa bumi. Kami sediakan untuk anda\n'
              'dengan mudah.',
              style: AppTheme.greyTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 35,
              color: AppColors.blackColor,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 320,
              child: FutureBuilder<BeritaModel>(
                future: BeritaService.getAllBerita(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text(snapshot.error.toString(),
                            style: AppTheme.blackTextStyle));
                  }
                  if (snapshot.hasData) {
                    List data = snapshot.data!.data as List;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final BeritaData berita = data[index];
                        return UpdateCard(data: berita.attributes!);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget LayananPopulerSection() {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
        child: Column(
          children: [
            Text(
              'Layanan Terbaru',
              style: AppTheme.blackTextStyle.copyWith(
                fontSize: 56,
                fontWeight: AppTheme.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   decoration: BoxDecoration(
            //     color: Color(0xfff7f7f7),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         'TERBARU',
            //         style: AppTheme.primaryTextStyle.copyWith(
            //           fontWeight: AppTheme.semiBold,
            //         ),
            //       ),
            //       const SizedBox(width: 24),
            //       Text(
            //         'POPULER',
            //         style: AppTheme.blackTextStyle.copyWith(
            //           fontWeight: AppTheme.semiBold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                // InkWell(
                //   onTap: _scrollToBefore,
                //   child: const CircleAvatar(
                //     radius: 23,
                //     backgroundColor: AppColors.primaryColor,
                //     child: Icon(
                //       Icons.keyboard_arrow_left_rounded,
                //       size: 30,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 20,
                // ),
                Expanded(
                  child: FutureBuilder(
                    future: LayananServices.getAllLayanans(page: 1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) {
                        return Center(
                            child: Text(snapshot.error.toString(),
                                style: AppTheme.blackTextStyle));
                      }

                      Layanan data = snapshot.data!;
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final LayananData layanan = data.data![index];
                            return LayananPopulerCard(
                              data: layanan.attributes,
                              idProduct: layanan.id.toString(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                // const SizedBox(
                //   width: 20,
                // ),
                // InkWell(
                //   onTap: _scrollToNext,
                //   child: const CircleAvatar(
                //     radius: 23,
                //     backgroundColor: AppColors.primaryColor,
                //     child: Icon(
                //       Icons.keyboard_arrow_right_rounded,
                //       size: 30,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              onTap: () {
                context.go('/layanan');
              },
              titleButton: 'SELENGKAPNYA',
            ),
          ],
        ),
      ),
    );
  }

  Widget OpeningSection(BuildContext context) {
    final settingController = context.watch<SettingController>();
    final setting = settingController.setting.data!.attributes!;
    final idYoutube = YoutubePlayerController.convertUrlToId(
        setting.homepageJumbotronVideoUrl.toString());

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 150.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildWebViewX(idYoutube!),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  setting.homepageJumbotronJudulUtama.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 60,
                    fontWeight: AppTheme.bold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  setting.homepageJumbotronIntro.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.medium,
                  ),
                  maxLines: 5,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  onTap: () {
                    context.go('/layanan');
                  },
                  titleButton: 'LIHAT SEMUA LAYANAN',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWebViewX(String id, {bool isMobile = false}) {
    String initialContent = "";

    if (isMobile) {
      initialContent =
          '<iframe width ="300" height="200" src="https://www.youtube.com/embed/$id" frameborder="0"  allowfullscreen></iframe>';
    } else {
      initialContent =
          '<iframe width="568" height="400" src="https://www.youtube.com/embed/$id" frameborder="0"  allowfullscreen></iframe>';
    }

    late WebViewXController webviewController;

    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      width: isMobile ? 320 : 600,
      height: isMobile ? 230 : 500,
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
      navigationDelegate: (navigation) {
        return NavigationDecision.navigate;
      },
    );
  }

  Widget LayananBMKGSection() {
    final settingController = context.watch<SettingController>();
    final setting = settingController.setting.data!.attributes!;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.darkprimaryColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 150.0,
        vertical: 50.0,
      ),
      child: Column(
        children: [
          Text(
            setting.homepageLayananJudulUtama.toString(),
            style: AppTheme.whiteTextStyle.copyWith(
              fontSize: 56,
              fontWeight: AppTheme.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            setting.homepageLayananIntro.toString(),
            style: AppTheme.whiteTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 234,
            child: FutureBuilder(
              future: LayananServices.getAllBidangLayanans(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return Center(
                      child: Text('Gagal mengambil data, coba lagi',
                          style: AppTheme.whiteTextStyle));
                }
                if (snapshot.hasData) {
                  List<bidang_layanan_model.BidangLayanan> bidangLayanans =
                      snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: bidangLayanans.length,
                    itemBuilder: (context, index) {
                      final data = bidangLayanans[index].attributes!;
                      return InkWell(
                        onTap: () {
                          context.go('/layanan/${data.slug}');
                        },
                        child: LayananCard(
                          index: index,
                          imagePath:
                              '${Constant.host}${data.gambar!.data!.attributes!.url}',
                          titleLayanan: data.judul!,
                          descriptionLayanan: data.intro ?? '',
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          PrimaryButton(onTap: () {}, titleButton: 'LIHAT SEMUA LAYANAN'),
        ],
      ),
    );
  }

  Widget OpeningSectionMobile(BuildContext context) {
    final settingController = context.watch<SettingController>();
    final setting = settingController.setting.data!.attributes!;
    final idYoutube = YoutubePlayerController.convertUrlToId(
        setting.homepageJumbotronVideoUrl.toString());
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.all(
        20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWebViewX(idYoutube!, isMobile: true),
          const SizedBox(height: 10),
          Column(
            children: [
              Text(
                setting.homepageJumbotronJudulUtama.toString(),
                style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: AppTheme.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                setting.homepageJumbotronIntro.toString(),
                style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: AppTheme.medium,
                ),
                textAlign: TextAlign.center,
                maxLines: 5,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 12,
              ),
              PrimaryButton(
                onTap: () {
                  context.go('/layanan');
                },
                titleButton: 'LIHAT SEMUA LAYANAN',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget LayananBMKGSectionMobile() {
    final settingController = context.watch<SettingController>();
    final setting = settingController.setting.data!.attributes!;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.darkprimaryColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            setting.homepageLayananJudulUtama.toString(),
            style: AppTheme.whiteTextStyle.copyWith(
              fontSize: 32,
              fontWeight: AppTheme.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            setting.homepageLayananIntro.toString(),
            style: AppTheme.whiteTextStyle.copyWith(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 234,
            child: FutureBuilder(
              future: LayananServices.getAllBidangLayanans(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return Center(
                      child: Text('Gagal mengambil data, coba lagi',
                          style: AppTheme.whiteTextStyle));
                }
                if (snapshot.hasData) {
                  List<bidang_layanan_model.BidangLayanan> bidangLayanans =
                      snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: bidangLayanans.length,
                    itemBuilder: (context, index) {
                      final data = bidangLayanans[index].attributes!;
                      return InkWell(
                        onTap: () {
                          context.go('/layanan/${data.slug}');
                        },
                        child: LayananCard(
                          index: index,
                          imagePath:
                              '${Constant.host}${data.gambar!.data!.attributes!.url}',
                          titleLayanan: data.judul!,
                          descriptionLayanan: data.intro ?? '',
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          PrimaryButton(
              onTap: () {
                context.go('/layanan');
              },
              titleButton: 'LIHAT SEMUA LAYANAN'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget UpdateSectionMobile() {
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Update Terkini',
            style: AppTheme.blackTextStyle.copyWith(
              fontSize: 56,
              fontWeight: AppTheme.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Akses informasi terkini beragam kejadian cuaca, iklim dan gempa bumi. Kami sediakan untuk anda\n'
            'dengan mudah.',
            style: AppTheme.greyTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 35,
            color: AppColors.blackColor,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 320,
            child: FutureBuilder<BeritaModel>(
              future: BeritaService.getAllBerita(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(
                      child: Text(snapshot.error.toString(),
                          style: AppTheme.blackTextStyle));
                }
                if (snapshot.hasData) {
                  List data = snapshot.data!.data as List;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final BeritaData berita = data[index];
                      return UpdateCardMobile(data: berita.attributes!);
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          PrimaryButton(
              onTap: () {
                context.go('/berita');
              },
              titleButton: "LIHAT SELENGKAPNYA"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget LayananPopulerSectionMobile() {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              'Layanan Populer',
              style: AppTheme.blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: AppTheme.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: LayananServices.getAllLayanans(page: 1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return Center(
                      child: Text(snapshot.error.toString(),
                          style: AppTheme.blackTextStyle));
                }

                Layanan data = snapshot.data!;
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final LayananData layanan = data.data![index];
                      return LayananPopulerCard(
                        data: layanan.attributes,
                        idProduct: layanan.id.toString(),
                        isMobile: true,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              onTap: () {
                context.go('/layanan');
              },
              titleButton: 'SELENGKAPNYA',
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class _WidgetFactory extends WidgetFactory {
  @override
  final bool webView;

  @override
  final bool webViewJs;

  _WidgetFactory({
    required this.webView,
    required this.webViewJs,
  });
}
