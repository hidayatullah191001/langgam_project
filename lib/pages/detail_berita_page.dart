part of 'pages.dart';

class DetailBeritaPage extends StatelessWidget {
  const DetailBeritaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();
    final String id = ModalRoute.of(context)?.settings.arguments as String;
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
            // return Query(
            //   options: QueryOptions(document: gql(BeritaQuery.queryBerita(id))),
            //   builder: (result, {fetchMore, refetch}) {
            //     if (result.isLoading) {
            //       return Center(child: CircularProgressIndicator());
            //     }

            //     if (result.data == null) {
            //       return const Center(
            //         child: Text('Data not found'),
            //       );
            //     }
            //     final berita = result.data!['post']['data']['attributes'];
            //     return CustomScrollView(
            //       cacheExtent: 5000,
            //       slivers: [
            //         SliverList(
            //           delegate: SliverChildListDelegate([
            //             const BannerTop(),
            //           ]),
            //         ),
            //         const SliverAppBar(
            //           pinned: true,
            //           floating: false,
            //           collapsedHeight: 101.0,
            //           automaticallyImplyLeading: false,
            //           flexibleSpace: Navbar(),
            //           actions: [SizedBox()],
            //         ),
            //         SliverList(
            //           delegate: SliverChildListDelegate([
            //             ContentSection(berita),
            //             const Footer(),
            //           ]),
            //         ),
            //       ],
            //     );
            //   },
            // );
            return CustomScrollView(
              cacheExtent: 5000,
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
                SliverList(
                  delegate: SliverChildListDelegate([
                    // ContentSection(berita),
                    const Footer(),
                  ]),
                ),
              ],
            );
          }
        },
      ),
      endDrawer: controller.selectedDrawer == 'Login'
          ? const LoginDrawer()
          : (controller.selectedDrawer == 'Cart'
              ? const CartDrawer()
              : Container()),
    );
  }

  Widget ContentSection(dynamic berita) {
    final String urlGambar =
        '${Constant.host}${berita['gambar']['data']['attributes']['url']}';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            berita['judul'].toString(),
            style: AppTheme.blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: AppTheme.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Image.network(
          urlGambar ??
              'https://img.freepik.com/premium-vector/vector-mock-up-daily-newspaper-newspaper-template-newspaper-with-location-copy-space-newspaper-template-with-world-news-economy-business-headlines-daily-news-isolated-white-background_435184-1137.jpg',
        ),
        const SizedBox(height: 20),
        JsonTextWidget(
          jsonData: berita['konten'] as List,
        ),
      ]),
    );
  }
}

class JsonTextWidget extends StatelessWidget {
  final List<dynamic> jsonData;

  JsonTextWidget({required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: jsonData.length,
      itemBuilder: (context, index) {
        final item = jsonData[index];

        if (item['type'] == 'heading') {
          if (item['level'] == 1) {
            return Text(
              item['children'][0]['text'],
              style: AppTheme.blackTextStyle
                  .copyWith(fontSize: 24, fontWeight: AppTheme.bold),
            );
          } else if (item['level'] == 2) {
            return Text(
              item['children'][0]['text'],
              style: AppTheme.blackTextStyle
                  .copyWith(fontSize: 22, fontWeight: AppTheme.bold),
            );
          } else if (item['level'] == 3) {
            return Text(
              item['children'][0]['text'],
              style: AppTheme.blackTextStyle
                  .copyWith(fontSize: 20, fontWeight: AppTheme.bold),
            );
          } else if (item['level'] == 4) {
            return Text(
              item['children'][0]['text'],
              style: AppTheme.blackTextStyle
                  .copyWith(fontSize: 18, fontWeight: AppTheme.bold),
            );
          } else if (item['level'] == 5) {
            return Text(
              item['children'][0]['text'],
              style:
                  AppTheme.blackTextStyle.copyWith(fontWeight: AppTheme.bold),
            );
          } else if (item['level'] == 6) {
            return Text(
              item['children'][0]['text'],
              style:
                  AppTheme.blackTextStyle.copyWith(fontWeight: AppTheme.bold),
            );
          }
        } else if (item['type'] == 'paragraph') {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              item['children'][0]['text'],
              style: AppTheme.greyTextStyle,
            ),
          );
        }
      },
    );
  }
}
