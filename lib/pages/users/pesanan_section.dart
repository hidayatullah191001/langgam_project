part of '../pages.dart';

class PesananSection extends StatelessWidget {
  const PesananSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permintaanController = context.watch<PermintaanController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PESANAN',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'TANGGAL',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'STATUS',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 30),
            Text(
              'TOTAL',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 40),
            Text(
              'AKSI',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const Divider(),

        // Disini List Item Pesanan

        FutureBuilder(
          future: PermintaanService.getAllPermintaanCustomer(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      'lottie/empty_cart.json',
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kamu belum ada memiliki pesanan',
                      style: AppTheme.greyTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              // permintaanController
              //     .setPermintaanFromFutureBuilder(snapshot.data);
              // final permintaan = permintaanController.permintaan;

              ListPermintaanModel model = snapshot.data as ListPermintaanModel;

              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: model.data!.length,
                itemBuilder: (context, index) {
                  print(model.data![index]);
                  return ItemPesanan(pesananUser: model.data![index]);
                },
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}

class ItemPesanan extends StatelessWidget {
  final Data pesananUser;
  const ItemPesanan({super.key, required this.pesananUser});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    final permintaanController = context.watch<PermintaanController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: InkWell(
                child: Text(
                  '#${pesananUser.attributes!.nomorPermintaan ?? " ---"}',
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                AppMethods.date(pesananUser.attributes!.createdAt.toString()),
                style: AppTheme.softgreyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                pesananUser.attributes!.status.toString(),
                style: AppTheme.softgreyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'Rp ${AppMethods.currency(pesananUser.attributes!.harga.toString())}',
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                  children: [
                    TextSpan(
                        text:
                            ' untuk ${pesananUser.attributes!.kuantitas.toString()} item',
                        style: AppTheme.softgreyTextStyle),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              titleButton: 'LIHAT',
              onTap: () {
                controller.pickMenu('Detail pesanan', 1);
                permintaanController.setDataPermintaan(pesananUser);
              },
              fontSize: 12,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class DetailPesananSection extends StatelessWidget {
  const DetailPesananSection({super.key});

  @override
  Widget build(BuildContext context) {
    final permintaanController = context.watch<PermintaanController>();
    String status =
        permintaanController.dataPermintaan.attributes!.status.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Pesanan #',
            style: AppTheme.greyTextStyle,
            children: [
              TextSpan(
                text:
                    '${permintaanController.dataPermintaan.attributes!.nomorPermintaan ?? ' ---'}',
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: ' dilakuka pada ',
                style: AppTheme.greyTextStyle,
              ),
              TextSpan(
                text: AppMethods.date(permintaanController
                    .dataPermintaan.attributes!.createdAt
                    .toString()),
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: ' dan saat ini ',
                style: AppTheme.greyTextStyle,
              ),
              TextSpan(
                text:
                    '${permintaanController.dataPermintaan.attributes!.status}',
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: '.',
                style: AppTheme.greyTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'PAYMENT INFO',
          style: AppTheme.blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: AppTheme.bold,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Reference:',
          style: AppTheme.blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: AppTheme.bold,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.circle,
                    color: AppColors.greyColor,
                    size: 15,
                  ),
                  const SizedBox(width: 25),
                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         '23 Jan, 2024 | 1:37 AM',
                  //         style: AppTheme.greyTextStyle.copyWith(
                  //           fontWeight: AppTheme.medium,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 10),
                  //       Text(
                  //         'menunggu persetujuan admin Status pesanan berubah dari Pembayaran tertunda menjadi Menuggu persetujuan',
                  //         style: AppTheme.greyTextStyle.copyWith(
                  //           fontWeight: AppTheme.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: Text(
                      'menunggu persetujuan admin Status pesanan berubah dari Pembayaran tertunda menjadi Menuggu persetujuan',
                      style: AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
        Text('Kecamatan', style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text('Kota Jakarta Timur',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text('Provinsi DKI Jakarta',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text('Pos 46467', style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
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
      ],
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
