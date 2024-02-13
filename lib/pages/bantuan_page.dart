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
                    ContentSection(),
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
          : Container(),
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
