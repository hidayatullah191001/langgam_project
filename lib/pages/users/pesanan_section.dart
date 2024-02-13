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
                style: pesananUser.attributes!.status == 'Selesai'
                    ? AppTheme.greenTextStyle
                    : AppTheme.redTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      'Rp ${AppMethods.currency(pesananUser.attributes!.total.toString())}',
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

class DetailPesananSection extends StatefulWidget {
  const DetailPesananSection({super.key});

  @override
  State<DetailPesananSection> createState() => _DetailPesananSectionState();
}

class _DetailPesananSectionState extends State<DetailPesananSection> {
  Map<String, dynamic> user = {};
  bool isDataCartLoaded = false;
  // File? _selectedDocument;

  html.File? _selectedDocument;

  void openURLInNewTab(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final permintaanController = context.watch<PermintaanController>();
    final accountcontroller = context.watch<MyAccountController>();

    String status =
        permintaanController.dataPermintaan.attributes!.status.toString();
    String id = permintaanController.dataPermintaan.id.toString();
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
                style: permintaanController.dataPermintaan.attributes!.status ==
                        'Selesai'
                    ? AppTheme.greenTextStyle
                    : AppTheme.redTextStyle,
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
              if (status == "Menunggu Persetujuan") ...[
                StatusWidget(
                    message:
                        'Saat ini pesanan berstatus $status. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses menunggu persetujuan'),
              ] else if (status == "Verifikasi Persyaratan") ...[
                const StatusWidget(
                    message:
                        'Saat ini pesanan berstatus Menunggu Persetujuan. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses menunggu persetujuan'),
                StatusWidget(
                    message: 'Pesanan memasuki tahapan $status oleh admin'),
              ] else if (status == "Menunggu Pembayaran") ...[
                const StatusWidget(
                    message:
                        'Saat ini pesanan berstatus Menunggu Persetujuan. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses menunggu persetujuan'),
                const StatusWidget(
                    message:
                        'Pesanan memasuki tahapan Verifikasi Persyaratan oleh admin'),
                StatusWidget(
                    message:
                        'Pesanan sekarang berstatus $status. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
              ] else if (status == "Verifikasi Pembayaran") ...[
                const StatusWidget(
                    message:
                        'Saat ini pesanan berstatus Menunggu Persetujuan. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses menunggu persetujuan'),
                const StatusWidget(
                    message:
                        'Pesanan memasuki tahapan Verifikasi Persyartan oleh admin'),
                const StatusWidget(
                    message:
                        'Pesanan sekarang berstatus Menuggu Pembayaran. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
                StatusWidget(
                    message: 'Pesanan memasuk tahapan $status oleh admin'),
              ] else if (status == "Sedang Diproses") ...[
                const StatusWidget(
                    message:
                        'Saat ini pesanan berstatus Menunggu Persetujuan. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses menunggu persetujuan'),
                const StatusWidget(
                    message:
                        'Pesanan memasuki tahapan Verifikasi Persyaratan oleh admin'),
                const StatusWidget(
                    message:
                        'Pesanan sekarang berstatus Menuggu Pembayaran. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
                const StatusWidget(
                    message:
                        'Pesanan memasuki tahapan Verifikasi Pembayaran oleh admin'),
                StatusWidget(message: 'Pesanan $status oleh admin'),
              ] else if (status == "Selesai") ...[
                const StatusWidget(
                    message:
                        'Saat ini pesanan berstatus Menunggu Persetujuan. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses menunggu persetujuan'),
                const StatusWidget(
                    message:
                        'Pesanan memasuki tahapan Verifikasi Persyaratan oleh admin'),
                const StatusWidget(
                    message:
                        'Pesanan sekarang berstatus Menuggu Pembayaran. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
                const StatusWidget(
                    message:
                        'Pesanan memasuki tahapan Verifikasi Pembayaran oleh admin'),
                const StatusWidget(
                    message: 'Pesanan Sedang Diproses oleh admin'),
                StatusWidget(message: 'Pesanan telah $status'),
              ]
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
          title:
              '${permintaanController.dataPermintaan.attributes!.layanan!.attributes!.judul} x ${permintaanController.dataPermintaan.attributes!.kuantitas}',
          price: AppMethods.currency(
              permintaanController.dataPermintaan.attributes!.total.toString()),
        ),
        ItemDetailPesanan(
          title: 'Tipe Pesanan',
          price:
              permintaanController.dataPermintaan.attributes!.komersial == true
                  ? 'Komersial'
                  : 'Free',
        ),
        ItemDetailPesanan(
          title: 'Lokasi Pesanan:',
          price:
              '${permintaanController.dataPermintaan.attributes!.metadata![0].data}',
        ),
        ItemDetailPesanan(
          title: 'Catatan User:',
          price:
              '${permintaanController.dataPermintaan.attributes!.metadata![1].data}',
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
                    AppMethods.currency(permintaanController
                        .dataPermintaan.attributes!.total
                        .toString()),
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
        Text(permintaanController.dataPermintaan.attributes!.nama.toString(),
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text('Alamat ${permintaanController.dataPermintaan.attributes!.alamat}',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text(
            'Kecamatan ${permintaanController.dataPermintaan.attributes!.kecamatan}',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text('Kota ${permintaanController.dataPermintaan.attributes!.kota}',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text(
            'Provinsi ${permintaanController.dataPermintaan.attributes!.provinsi}',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text(
            'No Telephone ${permintaanController.dataPermintaan.attributes!.telepon}',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        Text('Email ${permintaanController.dataPermintaan.attributes!.email}',
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
        permintaanController.dataPermintaan.attributes!.suratPermintaan!.data !=
                null
            ? Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.file,
                    size: 38,
                    color: AppColors.softgreyColor,
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      openURLInNewTab(
                          '${Constant.host}${permintaanController.dataPermintaan.attributes!.suratPermintaan!.data!.attributes!.url}');
                    },
                    child: Text(
                      permintaanController.dataPermintaan.attributes!
                          .suratPermintaan!.data!.attributes!.name
                          .toString(),
                      style: AppTheme.primaryTextStyle,
                    ),
                  ),
                ],
              )
            : SecondaryButton(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowMultiple: false,
                    allowedExtensions: [
                      'pdf',
                      'doc',
                      'docx',
                      'txt',
                      'jpg',
                      'png',
                      'jpeg'
                    ],
                  );

                  final resultUploadFile = await CheckoutService.uploadFile(
                      result!.files.first.bytes,
                      result.files.first.name,
                      permintaanController
                          .dataPermintaan.attributes!.layanan!.id
                          .toString(),
                      'surat_permintaan');

                  if (resultUploadFile['success'] == true) {
                    int? idFileUpload = resultUploadFile['idFileUpload'];
                    final data = {
                      "data": {
                        "surat_permintaan": idFileUpload,
                      }
                    };
                    final update = await PermintaanService.updatePermintaan(
                        permintaanController.dataPermintaan.id.toString(),
                        data);
                    if (update) {
                      CoolAlert.show(
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.3,
                        type: CoolAlertType.success,
                        text: 'Surat permintaan berhasil diupload',
                      ).then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/my-account', (route) => false);
                        accountcontroller.pickMenu('Pesanan', 1);
                      });
                    } else {
                      CoolAlert.show(
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.3,
                        type: CoolAlertType.error,
                        text: 'Gagal update permintaan',
                      );
                    }
                  } else {
                    CoolAlert.show(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.3,
                      type: CoolAlertType.error,
                      text: 'Ada masalah pada saat upload, coba lagi',
                    );
                  }
                },
                titleButton: 'PILIH & UPLOAD FILE'),
        const SizedBox(height: 30),
        Row(
          children: [
            Text(
              'Billing Pembayaran',
              style: AppTheme.blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: AppTheme.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Divider(),
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.file,
                      size: 38,
                      color: AppColors.softgreyColor,
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${permintaanController.dataPermintaan.attributes!.billingPembayaran!.data!.attributes!.url}');
                      },
                      child: Text(
                        permintaanController.dataPermintaan.attributes!
                            .billingPembayaran!.data!.attributes!.name
                            .toString(),
                        style: AppTheme.primaryTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            : Text(
                'Belum ada Billing Pembayaran!',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
        const SizedBox(height: 30),
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Row(
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
              )
            : Container(),
        const SizedBox(height: 15),
        const Divider(),
        const SizedBox(height: 15),
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.file,
                    size: 38,
                    color: AppColors.softgreyColor,
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      openURLInNewTab(
                          '${Constant.host}${permintaanController.dataPermintaan.attributes!.billingPembayaran!.data!.attributes!.url}');
                    },
                    child: Text(
                      permintaanController.dataPermintaan.attributes!
                          .billingPembayaran!.data!.attributes!.name
                          .toString(),
                      style: AppTheme.primaryTextStyle,
                    ),
                  ),
                ],
              )
            : SecondaryButton(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowMultiple: false,
                    allowedExtensions: [
                      'pdf',
                      'doc',
                      'docx',
                      'txt',
                      'jpg',
                      'png',
                      'jpeg'
                    ],
                  );

                  final resultUploadFile = await CheckoutService.uploadFile(
                      result!.files.first.bytes,
                      result.files.first.name,
                      permintaanController
                          .dataPermintaan.attributes!.layanan!.id
                          .toString(),
                      'bukti_pembayaran');

                  if (resultUploadFile['success'] == true) {
                    int? idFileUpload = resultUploadFile['idFileUpload'];
                    final data = {
                      "data": {
                        "bukti_pembayaran": idFileUpload,
                      }
                    };
                    final update = await PermintaanService.updatePermintaan(
                        permintaanController.dataPermintaan.id.toString(),
                        data);
                    if (update) {
                      // ignore: use_build_context_synchronously
                      CoolAlert.show(
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.3,
                        type: CoolAlertType.success,
                        text: 'Bukti pembayaran berhasil diupload',
                      ).then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/my-account', (route) => false);
                        accountcontroller.pickMenu('Pesanan', 1);
                      });
                    } else {
                      // ignore: use_build_context_synchronously
                      CoolAlert.show(
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.3,
                        type: CoolAlertType.error,
                        text: 'Gagal update permintaan',
                      );
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    CoolAlert.show(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.3,
                      type: CoolAlertType.error,
                      text: 'Ada masalah pada saat upload, coba lagi',
                    );
                  }
                },
                titleButton: 'PILIH DAN UPLOAD FILE',
              ),
        const SizedBox(height: 30),
        permintaanController
                    .dataPermintaan.attributes!.dokumenPermintaan!.data !=
                null
            ? Row(
                children: [
                  Text(
                    'Dokumen Permintaan',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ],
              )
            : Container(),
        const SizedBox(height: 15),
        const Divider(),
        permintaanController
                    .dataPermintaan.attributes!.dokumenPermintaan!.data !=
                null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.file,
                      size: 38,
                      color: AppColors.softgreyColor,
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${permintaanController.dataPermintaan.attributes!.dokumenPermintaan!.data!.attributes!.url}');
                      },
                      child: Text(
                        permintaanController.dataPermintaan.attributes!
                            .dokumenPermintaan!.data!.attributes!.name
                            .toString(),
                        style: AppTheme.primaryTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
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

class StatusWidget extends StatelessWidget {
  final String message;
  const StatusWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.circle,
          color: AppColors.greyColor,
          size: 15,
        ),
        const SizedBox(width: 25),
        Expanded(
          child: Text(
            message,
            style: AppTheme.greyTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
        ),
      ],
    );
  }
}
