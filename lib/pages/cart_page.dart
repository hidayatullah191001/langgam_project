part of 'pages.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

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
                SliverList(
                  delegate: SliverChildListDelegate([
                    HeroSectionCart(
                      heroPosition: 'KERANJANG BELANJA',
                    ),
                    ContentSection(),
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

  Widget ContentSection() {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(
        horizontal: 150,
        vertical: 50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 120,
                    ),
                    Text(
                      'PRODUK',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 140,
                    ),
                    Text(
                      'HARGA',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      'JUMLAH',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text(
                      'SUBTOTAL',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.close,
                          color: AppColors.greyColor,
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 70,
                          height: 50,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('images/product-1.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 170,
                          child: Expanded(
                            child: Text(
                              'Analisis dan Prakiraan Hujan Bulanan',
                              style: AppTheme.blackTextStyle.copyWith(
                                  fontWeight: AppTheme.bold, fontSize: 14),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 90,
                            child: Column(
                              children: [
                                Text(
                                  'Rp65.000',
                                  style: AppTheme.greyTextStyle
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '/ buku',
                                  style: AppTheme.greyTextStyle.copyWith(
                                      color: AppColors.softgreyColor,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
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
                                color: Colors.blue.withOpacity(0.1),
                                child: Text(
                                  1.toString(),
                                  style: AppTheme.blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: AppTheme.medium,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
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
                        const SizedBox(width: 20),
                        Text(
                          'Rp.65000',
                          style: AppTheme.primaryTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Container(
            width: 300,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.softgreyColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL KERANJANG BELANJA',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    fontSize: 24,
                  ),
                ),
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
          )
        ],
      ),
    );
  }
}
