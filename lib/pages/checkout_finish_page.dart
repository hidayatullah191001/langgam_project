part of 'pages.dart';

class CheckoutFinishPage extends StatelessWidget {
  const CheckoutFinishPage({Key? key}) : super(key: key);

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
                      heroPosition: 'SELESAI',
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
      color: AppColors.backgroundColor3,
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Akun Saya', style: AppTheme.primaryTextStyle)),
          const SizedBox(height: 30),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Nomor Pesanan:', style: AppTheme.greyTextStyle),
                  const SizedBox(height: 15),
                  Text(
                    '16533',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 80,
                color: AppColors.softgreyColor,
              ),
              Column(children: [
                Text('Tanggal:', style: AppTheme.greyTextStyle),
                const SizedBox(height: 15),
                Text(
                  'Januari 24, 2024',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ]),
              Container(
                width: 1,
                height: 80,
                color: AppColors.softgreyColor,
              ),
              Column(children: [
                Text('Email:', style: AppTheme.greyTextStyle),
                const SizedBox(height: 15),
                Text(
                  'dayat@gmail.com',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ]),
              Container(
                width: 1,
                height: 80,
                color: AppColors.softgreyColor,
              ),
              Column(children: [
                Text('Total:', style: AppTheme.greyTextStyle),
                const SizedBox(height: 15),
                Text(
                  'Rp166.500',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ]),
              Container(
                width: 1,
                height: 80,
                color: AppColors.softgreyColor,
              ),
              Column(children: [
                Text('Metode Pembayaran:', style: AppTheme.greyTextStyle),
                const SizedBox(height: 15),
                Text(
                  'Bayar Setelah Disetujui',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Harap kirimkan pembayaran setelah persetujuan pesanan.',
            style: AppTheme.greyTextStyle,
          ),
          // const SizedBox(height: 30),
          // Text(
          //   'Payment Info',
          //   style: AppTheme.blackTextStyle.copyWith(
          //     fontSize: 20,
          //     fontWeight: AppTheme.bold,
          //     letterSpacing: 1.2,
          //   ),
          // ),
          const SizedBox(height: 30),
          Text(
            'RINCIAN PESANAN',
            style: AppTheme.blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: AppTheme.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          Column(
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
                      'PRODUK',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: AppTheme.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      'TOTAL',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: AppTheme.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
          ItemDetailPesanan(
            title: 'Buku Peta Ketinggian Hilal x 1',
            price: 'Rp150.000',
          ),
          ItemDetailPesanan(
            title: 'Subtotal:',
            price: 'Rp150.000',
          ),
          ItemDetailPesanan(
            title: 'Pajak:',
            price: 'Rp16.500',
          ),
          Column(
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
                      'TOTAL:',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        letterSpacing: 1.1,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Rp166.500',
                      style: AppTheme.primaryTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        letterSpacing: 1.1,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
          const SizedBox(height: 30),
          Text('File: coba.pdf', style: AppTheme.greyTextStyle),
          const SizedBox(height: 15),
          Text(
            'ALAMAT PENAGIHAN',
            style: AppTheme.blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: AppTheme.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          Text('Nama depan nama belakang',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Alamat pulomas',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Kecamatan',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Kota Jakarta Timur',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Provinsi DKI Jakarta',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Pos 46467',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('No Telephone 08973473847',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Email dayat@gmail.com',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
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
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.file,
                size: 38,
                color: AppColors.softgreyColor,
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {},
                child: Text(
                  'coba.pdf',
                  style: AppTheme.primaryTextStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Bukti Pembayaran',
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
            titleButton: 'CHOOSE FILE',
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 30),
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
