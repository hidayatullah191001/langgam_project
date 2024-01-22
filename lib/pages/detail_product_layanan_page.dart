part of 'pages.dart';

class DetailProductLayananPage extends StatefulWidget {
  const DetailProductLayananPage({Key? key}) : super(key: key);

  @override
  State<DetailProductLayananPage> createState() =>
      _DetailProductLayananPageState();
}

class _DetailProductLayananPageState extends State<DetailProductLayananPage> {
  String stateDesk = 'DESKRIPSI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
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
                    ContentSection(),
                    const Footer(),
                  ],
                ),
              ),
            ],
          );
        }
      }),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget ContentSection() {
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {},
                              titleButton: 'TAMBAH KE KERANJANG',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {},
                              titleButton: 'PESAN SEKARANG',
                            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  stateDesk == 'DESKRIPSI'
                      ? Container(
                          width: 50,
                          height: 3,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox(height: 3),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButtonHovered(
                    text: 'DESKRIPSI',
                    onTap: () {
                      setState(() {
                        stateDesk = 'DESKRIPSI';
                      });
                    },
                    styleBeforeHovered: stateDesk == 'DESKRIPSI'
                        ? AppTheme.blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          )
                        : AppTheme.greyTextStyle.copyWith(
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
              const SizedBox(width: 24),
              Column(
                children: [
                  stateDesk == 'SYARAT & KETENTUAN'
                      ? Container(
                          width: 50,
                          height: 3,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox(height: 3),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButtonHovered(
                    text: 'SYARAT & KETENTUAN',
                    onTap: () {
                      setState(() {
                        stateDesk = 'SYARAT & KETENTUAN';
                      });
                    },
                    styleBeforeHovered: stateDesk == 'SYARAT & KETENTUAN'
                        ? AppTheme.blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: AppTheme.bold,
                          )
                        : AppTheme.greyTextStyle.copyWith(
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
            ],
          ),
          const SizedBox(height: 15),
          stateDesk == 'DESKRIPSI'
              ? ContentDeskripsi()
              : ContentSyaratKetentuan(),
          Divider(),
          UlasanSection(),
        ],
      ),
    );
  }

  Widget UlasanSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ULASAN',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ulasanUser.length,
                    itemBuilder: (context, index) {
                      final Map data = ulasanUser[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  radius: 18,
                                  child: FaIcon(
                                    FontAwesomeIcons.user,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['nama'],
                                      style: AppTheme.blackTextStyle
                                          .copyWith(fontWeight: AppTheme.bold),
                                    ),
                                    Text(data['email'],
                                        style: AppTheme.darkGreyTextStyle),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(data['ulasan'], style: AppTheme.greyTextStyle),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadilah yang pertama memberikan ulasan “Informasi Data Cuaca Khusus Untuk Kegiatan Olah Raga” ',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget ContentDeskripsi() {
    return Container(
      padding: const EdgeInsets.only(
        left: 150.0,
        right: 150.0,
        bottom: 50.0,
      ),
      child: Column(
        children: [
          Text(
            'Informasi cuaca memainkan peran kunci dalam kegiatan olahraga dengan berbagai manfaat, termasuk:',
            style: AppTheme.greyTextStyle,
          ),
        ],
      ),
    );
  }

  Widget ContentSyaratKetentuan() {
    return Container(
      padding: const EdgeInsets.only(
        left: 150.0,
        right: 150.0,
        bottom: 50.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 350,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/photo.jpeg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          const SizedBox(width: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: syaratKetentuan.map((data) {
              final title = data['title'];
              final items = data['items'] as List;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ...items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: const Icon(
                              Icons.circle,
                              size: 7,
                              color: AppColors.greyColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 500,
                            child: Text(
                              item,
                              style: AppTheme.greyTextStyle.copyWith(
                                height: 2,
                              ),
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
