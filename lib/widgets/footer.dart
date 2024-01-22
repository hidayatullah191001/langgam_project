part of 'widgets.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.footerprimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 100,
                    ),
                    const SizedBox(height: 35),
                    Text(
                      'LANGGAM - BMKG Wilayah II',
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 300,
                          child: Text(
                            'Jl. H. Abdulgani No.05, Cempaka Putih Ciputat Timur, Kota Tangerang Selatan Banten. Telp : (021) 7402739',
                            style: AppTheme.whiteTextStyle.copyWith(
                              fontSize: 14,
                              height: 2,
                            ),
                            maxLines: 5,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.phone_android,
                          color: AppColors.greyColor,
                          size: 15,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '082117974748',
                          style: AppTheme.whiteTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POST TERBARU',
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://www.quipper.com/id/blog/wp-content/uploads/2022/12/Pengertian-Teks-Berita-Ciri-Struktur-Jenis-Unsur-dan-Contoh.webp'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Perkembangan Potensi Cuaca Saat Periode Nataru 2023/2024',
                                style: AppTheme.whiteTextStyle.copyWith(
                                  fontWeight: AppTheme.medium,
                                ),
                                maxLines: 5,
                                softWrap: true,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Desember 25, 2023 Tidak ada Komentar',
                                style: AppTheme.softgreyTextStyle
                                    .copyWith(fontSize: 14),
                                maxLines: 5,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        height: 1,
                        color: Color(0xff355796),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://www.quipper.com/id/blog/wp-content/uploads/2022/12/Pengertian-Teks-Berita-Ciri-Struktur-Jenis-Unsur-dan-Contoh.webp'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Perkembangan Potensi Cuaca Saat Periode Nataru 2023/2024',
                                style: AppTheme.whiteTextStyle.copyWith(
                                  fontWeight: AppTheme.medium,
                                ),
                                maxLines: 5,
                                softWrap: true,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Desember 25, 2023 Tidak ada Komentar',
                                style: AppTheme.softgreyTextStyle
                                    .copyWith(fontSize: 14),
                                maxLines: 5,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BANTUAN',
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButtonHovered(
                      onTap: () {},
                      text: 'Akun Saya',
                    ),
                    TextButtonHovered(
                      onTap: () {},
                      text: 'Hubungi Kami',
                    ),
                    TextButtonHovered(
                      onTap: () {},
                      text: 'Panduan',
                    ),
                    TextButtonHovered(
                      onTap: () {},
                      text: 'Syarat & Ketentuan Layanan',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xff355796),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 150.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '(C) 2023 LANGGAM - Badan Meteorologi Klimatologi & Geofisika',
                    style: AppTheme.softgreyTextStyle.copyWith(
                      fontWeight: AppTheme.medium,
                    ),
                  ),
                ),
                Image.asset(
                  'images/payments.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
