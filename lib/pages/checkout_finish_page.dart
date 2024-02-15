part of 'pages.dart';

class CheckoutFinishPage extends StatelessWidget {
  const CheckoutFinishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = context.watch<PencarianController>();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1200) {
        return mobileView(searchController, context);
      } else {
        return webView(context);
      }
    });
  }

  Widget mobileView(
      PencarianController searchController, BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      body: Consumer(builder: (context, SettingController controller, widget) {
        if (controller.dataState == DataState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroSectionCartMobile(
                    heroPosition: 'SELESAI',
                    isSuccess: true,
                  ),
                  ContentSectionMobile(context),
                  const FooterMobile(),
                ],
              ),
            ),
          );
        }
      }),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget webView(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              HeroSectionCart(
                heroPosition: 'SELESAI',
                isSuccess: true,
              ),
              ContentSection(context),
              const Footer(),
            ]),
          ),
        ],
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget ContentSection(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    return Container(
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.successColor,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Terima kasih. Pesanan Anda telah diterima.',
                style: AppTheme.greenTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppTheme.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Selanjutnya harap mengupload berkas dan bukti pembayaran di halaman pesanan saya',
              style: AppTheme.greyTextStyle,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: PrimaryButton(
              onTap: () {
                context.go('/my-account');
                controller.pickMenu('Pesanan', 1);
              },
              titleButton: 'Lihat Pesanan Saya',
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SecondaryButton(
              onTap: () {
                context.replace('/');
              },
              titleButton: 'Kembali ke Halaman Utama',
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget ContentSectionMobile(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    return Container(
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.successColor,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Terima kasih. Pesanan Anda telah diterima.',
                style: AppTheme.greenTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: AppTheme.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Selanjutnya harap mengupload berkas dan bukti pembayaran di halaman pesanan saya',
              style: AppTheme.greyTextStyle,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: PrimaryButton(
              onTap: () {
                context.go('/my-account');
                controller.pickMenu('Pesanan', 1);
              },
              titleButton: 'Lihat Pesanan Saya',
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SecondaryButton(
              onTap: () {
                context.replace('/');
              },
              titleButton: 'Kembali ke Halaman Utama',
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget ItemDetailPesanan({required String title, required String price}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                  letterSpacing: 1.1,
                ),
              ),
              Text(
                price,
                style: AppTheme.primaryTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
