part of 'pages.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();

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
                    // ContentSection(context),
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

//   Widget ContentSection(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: 50,
//         horizontal: 150,
//       ),
//       child: Query(
//         options: QueryOptions(
//           document: gql(
//             BeritaQuery.queryBeritas(),
//           ),
//         ),
//         builder: (result, {fetchMore, refetch}) {
//           if (result.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (result.data == null) {
//             return const Center(
//               child: Text('Data not found'),
//             );
//           }
//           final posts = result.data!['posts']['data'];

//           return ListView.builder(
//             padding: EdgeInsets.zero,
//             itemCount: posts.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               final post = posts[index]['attributes'];
//               return ItemBerita(
//                 data: post,
//                 id: posts[index]['id'],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
}

class ItemBerita extends StatefulWidget {
  final dynamic data;
  final String id;
  const ItemBerita({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  State<ItemBerita> createState() => _ItemBeritaState();
}

class _ItemBeritaState extends State<ItemBerita> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    String urlGambar =
        '${Constant.host}${widget.data['gambar']['data']['attributes']['url']}';
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: isHovered ? 0.0 : -15.0,
              bottom: isHovered ? 0.0 : -15.0,
              left: isHovered ? 0.0 : -15.0,
              right: isHovered ? 0.0 : -15.0,
              child: Container(
                width: 250,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(urlGambar ??
                        'https://img.freepik.com/premium-vector/vector-mock-up-daily-newspaper-newspaper-template-newspaper-with-location-copy-space-newspaper-template-with-world-news-economy-business-headlines-daily-news-isolated-white-background_435184-1137.jpg'),
                    fit: BoxFit.cover,
                  ),
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
                      'Sulaiman',
                      style: AppTheme.greyTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Text(
                    widget.data['judul'],
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.data['intro'],
                    style: AppTheme.greyTextStyle,
                  ),
                  const SizedBox(height: 15),
                  PrimaryButton(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/berita/detail',
                        arguments: widget.id,
                      );
                    },
                    titleButton: 'LANJUTKAN MEMBACA',
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}
