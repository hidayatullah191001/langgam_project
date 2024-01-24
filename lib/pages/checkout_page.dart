part of 'pages.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

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
                // SliverList(
                //   delegate: SliverChildListDelegate([
                //     const BannerTop(),
                //   ]),
                // ),
                // const SliverAppBar(
                //   pinned: true,
                //   floating: false,
                //   collapsedHeight: 101.0,
                //   automaticallyImplyLeading: false,
                //   flexibleSpace: Navbar(),
                //   actions: [SizedBox()],
                // ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    HeroSectionCart(
                      heroPosition: 'PEMESANAN',
                    ),
                    ContentSection(context),
                    const Footer(),
                  ]),
                ),
              ],
            );
          }
        },
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget ContentSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Pelanggan lama?',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
              const SizedBox(width: 5),
              Text('Klik di sini untuk login',
                  style: AppTheme.primaryTextStyle
                      .copyWith(fontWeight: AppTheme.bold)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Surat Permintaan',
                style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                ),
              ),
              Text(
                '*',
                style: AppTheme.blackTextStyle.copyWith(
                  color: AppColors.dangerColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 15),
          SecondaryButton(
            onTap: () {},
            titleButton: 'Pilih File',
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailTagihanContent(),
              const SizedBox(width: 60),
              DetailPesananContent(context),
            ],
          )
        ],
      ),
    );
  }

  Widget DetailPesananContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'PESANAN ANDA',
              style: AppTheme.blackTextStyle.copyWith(
                  fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softgreyColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset.fromDirection(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRODUK',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'SUBTOTAL',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Widget List Item Produk di sidebox pesanan
                          Expanded(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColors.greyColor,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 60,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('images/product-1.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Analisis dan Prakiraan Hujan Bulanan',
                                        style:
                                            AppTheme.primaryTextStyle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: 80,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: AppColors.primaryColor,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              child: Text(
                                                1.toString(),
                                                style: AppTheme.blackTextStyle
                                                    .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: AppTheme.medium,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(6),
                                                    bottomRight:
                                                        Radius.circular(6),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppColors.primaryColor,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            'RP.65000',
                            style: AppTheme.greyTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          Text('Rp65.000', style: AppTheme.greyTextStyle),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pajak',
                            style: AppTheme.blackTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          Text(
                            'Rp7.150',
                            style: AppTheme.primaryTextStyle
                                .copyWith(fontWeight: AppTheme.bold),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTheme.blackTextStyle
                            .copyWith(fontWeight: AppTheme.bold, fontSize: 18),
                      ),
                      Text(
                        'Rp72.150',
                        style: AppTheme.primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onTap: () {},
                    titleButton: 'LANJUTKAN KE CHECKOUT',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Bayar Setelah Disetujui',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softgreyColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset.fromDirection(0, 2),
                ),
              ],
            ),
            child: Text(
              'Harap kirimkan pembayaran setelah pesanan anda kami setujui dan melengkapi kelengkapan data sesuai instruksi kami yang akan kami kirim ke akun anda,',
              style: AppTheme.greyTextStyle.copyWith(
                height: 1.2,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () {},
              titleButton: "BUAT PESANAN",
            ),
          ),
        ],
      ),
    );
  }

  Expanded DetailTagihanContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DETAIL TAGIHAN',
            style: AppTheme.blackTextStyle.copyWith(
                fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomFormUser(
                  title: 'Nama depan',
                  isMandatory: true,
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: CustomFormUser(
                  title: 'Nama belakang',
                  isMandatory: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            title: 'Nama perusahaan',
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            title: 'Alamat jalan',
            isMandatory: true,
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            title: 'Kode pos',
            isMandatory: true,
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            title: 'Telepon',
            isMandatory: true,
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            title: 'Alamat email',
            isMandatory: true,
          ),
          const SizedBox(height: 15),
          Text(
            'INFORMASI TAMBAHAN',
            style: AppTheme.blackTextStyle.copyWith(
                fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            title: 'Catatan Pesananan',
            minLines: 5,
            maxLines: 7,
          ),
        ],
      ),
    );
  }
}
