part of 'pages.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late YoutubePlayerController controlleryt;
  var isHovered = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    controlleryt = YoutubePlayerController.fromVideoId(
      videoId: 'Ib0YvZmOh8s',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );
    // final Map data = await AppSession.getUserInformation();
    // print(data['email']);
    setState(() {});
    super.initState();
  }

  void _scrollToNext() {
    double targetPosition = _scrollController.position.pixels + 300.0;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBefore() {
    double targetPosition = _scrollController.position.pixels - 300.0;
    _scrollController.animateTo(
      targetPosition,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
                    OpeningSection(context),
                    LayananBMKGSection(),
                    LayananPopulerSection(),
                    UpdateSection(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                UpdateCard(),
                SizedBox(width: 15),
                UpdateCard(),
                SizedBox(width: 15),
                UpdateCard(),
              ],
            )
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
              'Layanan Populer',
              style: AppTheme.blackTextStyle.copyWith(
                fontSize: 56,
                fontWeight: AppTheme.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TERBARU',
                    style: AppTheme.primaryTextStyle.copyWith(
                      fontWeight: AppTheme.semiBold,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'POPULER',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.semiBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: _scrollToBefore,
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                      height: 300,
                      child: Query(
                        options: QueryOptions(
                          document: gql(
                            LayananQuery.queryLayanans(),
                          ),
                        ),
                        builder: (result, {fetchMore, refetch}) {
                          if (result.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (result.data == null) {
                            return Center(
                              child: Text(
                                'Data not found',
                                style: AppTheme.greyTextStyle,
                              ),
                            );
                          }

                          final layanans = result.data!['layanans']['data'];

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              print('id ${layanans[index]['id']}');
                              final layanan = layanans[index]['attributes'];

                              return LayananPopulerCard(data: layanan);
                            },
                          );
                        },
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: _scrollToNext,
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(onTap: () {}, titleButton: 'SELENGKAPNYA'),
          ],
        ),
      ),
    );
  }

  Widget OpeningSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 150.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 568,
              height: 400,
              margin: const EdgeInsets.symmetric(vertical: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: YoutubePlayer(
                controller: controlleryt,
                aspectRatio: 16 / 9,
              ),
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
                    'LANGGAM',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 60,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Layanan Dalam Genggaman. BMKG Melayani berbagai penyediaan data meteorologi, klimatologi, geofisika, konsultasi dan peralatan meteorologi.',
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
                    onTap: () {},
                    titleButton: 'LIHAT SEMUA LAYANAN',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget LayananBMKGSection() {
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
            'LAYANAN BMKG',
            style: AppTheme.whiteTextStyle.copyWith(
              fontSize: 56,
              fontWeight: AppTheme.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Dapatkan akses cepat layanan data meteorologi, klimatologi, geofisika, konsultasi dan penyediaan\n'
            'peralatan meteorologi untuk berbagai kebutuhan anda.',
            style: AppTheme.whiteTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 234,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: layanans.length,
              itemBuilder: (context, index) {
                final data = layanans[index];
                return LayananCard(
                  index: index,
                  imagePath: data['imagePath'],
                  titleLayanan: data['title'],
                  descriptionLayanan: data['description'],
                );
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
}
