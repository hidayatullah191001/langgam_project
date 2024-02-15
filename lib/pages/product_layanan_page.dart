part of 'pages.dart';

class ProductLayananPage extends StatefulWidget {
  String? slugBidangLayanan;
  ProductLayananPage({Key? key, this.slugBidangLayanan = null})
      : super(key: key);

  @override
  State<ProductLayananPage> createState() => _ProductLayananPageState();
}

class _ProductLayananPageState extends State<ProductLayananPage> {
  String? title = "Semua Layanan";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedPageNumber = 1;
  int _selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    final searchController = context.watch<PencarianController>();
    return LayoutBuilder(builder: (context, constraints) {
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
        HeroSection(
          heroTitle: title!,
        ),
        ContentSection(),
        const Footer(),
      ],
    );
  }

  Widget defaultWidgetMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSection(
          heroTitle: title!,
        ),
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

  Widget ContentSection() {
    final controller = context.watch<LayananController>();
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString(),
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
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

                        bidang_layanan_model.BidangLayanan newData =
                            bidang_layanan_model.BidangLayanan(
                          id: 0,
                          attributes: bidang_layanan_model.Attributes(
                            judul: 'Semua Layanan',
                            intro: null,
                            slug: null,
                            createdAt: null,
                            updatedAt: null,
                          ),
                        );
                        data.insert(0, newData);

                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return TextButtonHovered(
                              text: data[index].attributes.judul.toString(),
                              onTap: () {
                                if (data[index].attributes.judul ==
                                    'Semua Layanan') {
                                  context.go('/layanan');
                                } else {
                                  context.go(
                                      '/layanan/${data[index].attributes.slug}');
                                }
                              },
                              styleHovered: AppTheme.blackTextStyle
                                  .copyWith(fontWeight: AppTheme.semiBold),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Container untuk membuat Filtering Nantinya
                  //Kemungkinan nanti pakai API
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   margin: const EdgeInsets.only(bottom: 20),
                  //   height: 30,
                  //   color: AppColors.greyColor,
                  // ),
                  FutureBuilder(
                    future: widget.slugBidangLayanan == null
                        ? LayananServices.getAllLayanans(
                            page: selectedPageNumber)
                        : LayananServices.getAllLayanans(
                            filter: true,
                            slugBidangLayanan: widget.slugBidangLayanan,
                            page: selectedPageNumber,
                          ),
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
                        Layanan data = snapshot.data!;
                        final meta = snapshot.data!.meta;
                        return Column(
                          children: [
                            ListView.builder(
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
                            ),
                            data.data!.length > 0
                                ? NumberPagination(
                                    onPageChanged: (int pageNumber) {
                                      //do somthing for selected page
                                      setState(() {
                                        selectedPageNumber = pageNumber;
                                      });
                                    },
                                    pageTotal: meta!.pagination!.pageCount!,
                                    pageInit:
                                        selectedPageNumber, // picked number when init page
                                    colorPrimary: AppColors.primaryColor,
                                    colorSub: AppColors.backgroundColor3,
                                  )
                                : Container(),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ContentSectionMobile() {
    final controller = context.watch<LayananController>();
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: FutureBuilder(
              future: LayananServices.getAllBidangLayanans(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final List data = snapshot.data as List;

                  bidang_layanan_model.BidangLayanan newData =
                      bidang_layanan_model.BidangLayanan(
                    id: 0,
                    attributes: bidang_layanan_model.Attributes(
                      judul: 'Semua Layanan',
                      intro: null,
                      slug: null,
                      createdAt: null,
                      updatedAt: null,
                    ),
                  );
                  data.insert(0, newData);

                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          TextButtonHovered(
                            text: data[index].attributes.judul.toString(),
                            onTap: () {
                              if (data[index].attributes.judul ==
                                  'Semua Layanan') {
                                context.go('/layanan');
                              } else {
                                context.go(
                                    '/layanan/${data[index].attributes.slug}');
                              }
                              setState(() {
                                _selectedCategoryIndex = index;
                              });
                            },
                            styleBeforeHovered: _selectedCategoryIndex == index
                                ? AppTheme.primaryTextStyle.copyWith(
                                    fontWeight: AppTheme.bold,
                                  )
                                : AppTheme.softgreyTextStyle.copyWith(
                                    fontWeight: AppTheme.semiBold,
                                  ),
                            styleHovered: AppTheme.blackTextStyle
                                .copyWith(fontWeight: AppTheme.semiBold),
                          ),
                          const SizedBox(width: 15),
                        ],
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          const SizedBox(height: 25),
          FutureBuilder(
            future: widget.slugBidangLayanan == null
                ? LayananServices.getAllLayanans(page: selectedPageNumber)
                : LayananServices.getAllLayanans(
                    filter: true,
                    slugBidangLayanan: widget.slugBidangLayanan,
                    page: selectedPageNumber,
                  ),
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
                Layanan data = snapshot.data!;
                final meta = snapshot.data!.meta;
                return Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final LayananData layanan = data.data![index];
                        return ItemLayananCardList(
                          data: layanan,
                          id: layanan.id!,
                          isMobile : true,
                        );
                      },
                    ),
                    data.data!.length > 0
                        ? NumberPagination(
                            onPageChanged: (int pageNumber) {
                              //do somthing for selected page
                              setState(() {
                                selectedPageNumber = pageNumber;
                              });
                            },
                            pageTotal: meta!.pagination!.pageCount!,
                            pageInit:
                                selectedPageNumber, // picked number when init page
                            colorPrimary: AppColors.primaryColor,
                            colorSub: AppColors.backgroundColor3,
                          )
                        : Container(),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
