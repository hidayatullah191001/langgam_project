part of 'pages.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key? key}) : super(key: key);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  int selectedPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      if (constraints.maxWidth <= 800) {
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
      endDrawer: controller.selectedDrawer == 'Login'
          ? const LoginDrawer()
          : Container(),
    );
  }

  Widget defaultWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSection(
          heroTitle: 'Semua Berita',
        ),
        ContentSection(context),
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
        HeroSection(
          heroTitle: 'Semua Berita',
        ),
        ContentSectionMobile(context),
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

  Widget ContentSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 150,
      ),
      child: FutureBuilder(
        future: BeritaService.getAllBerita(page: selectedPageNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('Data not Found', style: AppTheme.blackTextStyle),
            );
          } else {
            List<BeritaData> data = snapshot.data!.data!;
            final meta = snapshot.data!.meta!;
            return Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final BeritaAttributes post = data[index].attributes!;
                    return ItemBerita(
                      data: post,
                    );
                  },
                ),
                data.length > 0
                    ? NumberPagination(
                        onPageChanged: (int pageNumber) {
                          //do somthing for selected page
                          setState(() {
                            selectedPageNumber = pageNumber;
                          });
                        },
                        pageTotal: meta.pagination!.pageCount!,
                        pageInit:
                            selectedPageNumber, // picked number when init page
                        colorPrimary: AppColors.primaryColor,
                        colorSub: AppColors.backgroundColor3,
                      )
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget ContentSectionMobile(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 20,
      ),
      child: FutureBuilder(
        future: BeritaService.getAllBerita(page: selectedPageNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('Data not Found', style: AppTheme.blackTextStyle),
            );
          } else {
            List<BeritaData> data = snapshot.data!.data!;
            final meta = snapshot.data!.meta!;
            return Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final BeritaAttributes post = data[index].attributes!;
                    return ItemBeritaMobile(
                      data: post,
                    );
                  },
                ),
                data.length > 0
                    ? NumberPagination(
                        onPageChanged: (int pageNumber) {
                          setState(() {
                            selectedPageNumber = pageNumber;
                          });
                        },
                        pageTotal: meta.pagination!.pageCount!,
                        pageInit:
                            selectedPageNumber, // picked number when init page
                        colorPrimary: AppColors.primaryColor,
                        colorSub: AppColors.backgroundColor3,
                      )
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }
}

class ItemBerita extends StatefulWidget {
  final BeritaAttributes data;
  const ItemBerita({Key? key, required this.data}) : super(key: key);

  @override
  State<ItemBerita> createState() => _ItemBeritaState();
}

class _ItemBeritaState extends State<ItemBerita> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    String urlGambar =
        '${Constant.host}${widget.data.gambar!.data!.attributes!.url}';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(urlGambar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    'Diposting oleh',
                    style: AppTheme.greyTextStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.backgroundColor3,
                    child: Icon(
                      Icons.person,
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Admin',
                    style: AppTheme.greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ]),
                const SizedBox(height: 10),
                Text(
                  widget.data.judul!,
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: AppTheme.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.data.intro!,
                  style: AppTheme.greyTextStyle,
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  onTap: () {
                    context.go('/berita/${widget.data.slug}');
                  },
                  titleButton: 'LANJUTKAN MEMBACA',
                ),
                const SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemBeritaMobile extends StatefulWidget {
  final BeritaAttributes data;
  const ItemBeritaMobile({Key? key, required this.data}) : super(key: key);

  @override
  State<ItemBeritaMobile> createState() => _ItemBeritaStateMobile();
}

class _ItemBeritaStateMobile extends State<ItemBeritaMobile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    String urlGambar =
        '${Constant.host}${widget.data.gambar!.data!.attributes!.url}';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(urlGambar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Diposting oleh',
                  style: AppTheme.greyTextStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.backgroundColor3,
                  child: Icon(
                    Icons.person,
                    color: AppColors.greyColor,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'Admin',
                  style: AppTheme.greyTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Text(
                widget.data.judul!,
                style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                AppMethods.potongString(
                    input: widget.data.intro!, panjangMax: 50),
                style: AppTheme.greyTextStyle,
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                onTap: () {
                  context.go('/berita/${widget.data.slug}');
                },
                titleButton: 'LANJUTKAN MEMBACA',
              ),
              const SizedBox(height: 50),
            ],
          )
        ],
      ),
    );
  }
}
