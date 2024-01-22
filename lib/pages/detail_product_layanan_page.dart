part of 'pages.dart';

class DetailProductLayananPage extends StatelessWidget {
  const DetailProductLayananPage({Key? key}) : super(key: key);

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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 150,
              right: 150,
              top: 15,
            ),
            child: Row(
              children: [
                TextButtonHovered(
                  text: 'Beranda',
                  onTap: () {},
                  styleBeforeHovered: AppTheme.greyTextStyle,
                  styleHovered: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.semiBold),
                ),
                Text(' / ', style: AppTheme.greyTextStyle),
                TextButtonHovered(
                  text: 'Informasi Meteorologi',
                  onTap: () {},
                  styleBeforeHovered: AppTheme.greyTextStyle,
                  styleHovered: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.semiBold),
                ),
                Text(' / ', style: AppTheme.greyTextStyle),
                Text(
                  'Informasi Data Cuaca Khusus Untuk Kegiatan Olah Raga',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
              bottom: 50,
              left: 150,
              right: 150,
            ),
            child: Row(
              children: [
                Container(
                  width: 500,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('images/product-1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Informasi Data Cuaca Khusus Untuk Kegiatan Olah Raga',
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 50,
                          fontWeight: AppTheme.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp. 100.000',
                            style: AppTheme.primaryTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '/ lokasi / hari',
                            style: AppTheme.greyTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Informasi cuaca membantu dalam menjaga keselamatan, mengoptimalkan performa, serta menyesuaikan perencanaan acara olahraga untuk mendukung pengalaman yang aman dan positif bagi semua yang terlibat dalam kegiatan olahraga',
                        style: AppTheme.greyTextStyle.copyWith(
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
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
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(11),
                                color: Colors.blue.withOpacity(0.1),
                                child: Text(
                                  1.toString(),
                                  style: AppTheme.blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: AppTheme.medium,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          PrimaryButton(
                            onTap: () {},
                            titleButton: 'TAMBAH KE KERANJANG',
                          ),
                          const SizedBox(width: 15),
                          PrimaryButton(
                            onTap: () {},
                            titleButton: 'PESAN SEKARANG',
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonHovered(
                text: 'DESKRIPSI',
                onTap: () {},
                styleBeforeHovered: AppTheme.greyTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                ),
                styleHovered: AppTheme.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                ),
              ),
              const SizedBox(width: 24),
              TextButtonHovered(
                text: 'SYARAT & KETENTUAN',
                onTap: () {},
                styleBeforeHovered: AppTheme.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                ),
                styleHovered: AppTheme.blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: AppTheme.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
