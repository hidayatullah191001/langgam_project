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
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();
    final searchController = context.watch<PencarianController>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
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
            return CustomScrollView(
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
            );
          }
        },
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

    // if (bantuanController.bantuan == null) {
    //   return Center(child: CircularProgressIndicator());
    // } else {

    // }
  }
}
