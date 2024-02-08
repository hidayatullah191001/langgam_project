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
  Widget build(BuildContext context) {
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
                      HeroSection(
                        heroTitle: title!,
                      ),
                      ContentSection(),
                      const Footer(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget ContentSection() {
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
                                  Navigator.pushNamed(context, '/layanan');
                                } else {
                                  Navigator.pushNamed(context,
                                      '/layanan?bidang_layanan=${data[index].attributes.slug}');
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
                    initialData: [],
                    future: widget.slugBidangLayanan == null
                        ? LayananServices.getAllLayanans()
                        : LayananServices.getAllLayanans(
                            filter: true,
                            slugBidangLayanan: widget.slugBidangLayanan,
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
                        List data = snapshot.data as List;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final Layanan layanan = data[index];
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
