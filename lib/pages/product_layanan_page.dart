part of 'pages.dart';

class ProductLayananPage extends StatelessWidget {
  const ProductLayananPage({Key? key}) : super(key: key);

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
                        heroTitle: 'LAYANAN',
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
                    'LAYANAN',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: layanans.length,
                    itemBuilder: (context, index) {
                      final layanan = layanans[index];
                      return TextButtonHovered(
                        text: layanan['title'],
                        onTap: () {},
                        styleHovered: AppTheme.blackTextStyle
                            .copyWith(fontWeight: AppTheme.semiBold),
                      );
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
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 30,
                    color: AppColors.greyColor,
                  ),

                  Query(
                    options: QueryOptions(
                      document: gql(LayananQuery.queryLayanans()),
                    ),
                    builder: (result, {fetchMore, refetch}) {
                      if (result.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (result.data == null) {
                        return const Center(
                          child: Text('Data not found'),
                        );
                      }
                      final layanans = result.data!['layanans']['data'];

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: layanans.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print('id ${layanans[index]['id']}');
                          final layanan = layanans[index]['attributes'];
                          final model = LayananModel(
                            judul: layanan['judul'],
                            harga: layanan['harga'],
                            slug: layanan['slug'],
                            intro: layanan['intro'],
                            satuan: layanan['satuan'],
                            gambar: layanan['gambar']['data']['attributes']
                                ['url'],
                          );
                          return ItemLayananCardList(
                            data: model,
                            id: layanans[index]['id'],
                          );
                        },
                      );
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
