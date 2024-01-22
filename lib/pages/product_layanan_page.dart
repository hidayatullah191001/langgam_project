part of 'pages.dart';

class ProductLayananPage extends StatelessWidget {
  const ProductLayananPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const BannerTop(),
            ]),
          ),
          const SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            collapsedHeight: 101.0,
            automaticallyImplyLeading: false,
            flexibleSpace: Navbar(),
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
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ItemLayananCardList();
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
