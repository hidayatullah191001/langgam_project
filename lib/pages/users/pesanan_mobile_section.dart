part of '../pages.dart';

class PesananMobileSection extends StatefulWidget {
  const PesananMobileSection({Key? key}) : super(key: key);

  @override
  State<PesananMobileSection> createState() => _PesananMobileSectionState();
}

class _PesananMobileSectionState extends State<PesananMobileSection> {
  int selectedPageNumber = 1;
  int selectedPageSize = 10;

  List<int> _pageSize = [10, 20, 50, 100];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PermintaanService.getAllPermintaanCustomer(
          page: selectedPageNumber, pageSize: selectedPageSize),
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
          ListPermintaanModel model = snapshot.data as ListPermintaanModel;
          final meta = model.meta!;
          if (model.data!.isEmpty) {
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
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Entries', style: AppTheme.greyTextStyle),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: DropdownButtonFormField<String>(
                      value: selectedPageSize.toString(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedPageSize = int.parse(value!);
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: AppTheme.greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColors.greyColor, width: 2),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      items: _pageSize.map((data) {
                        return DropdownMenuItem<String>(
                          value: data.toString(),
                          child: Text(data.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.data!.length,
                itemBuilder: (context, index) {
                  return ItemPesananMobile(pesananUser: model.data![index]);
                },
              ),
              const SizedBox(height: 15),
              model.data!.isNotEmpty
                  ? NumberPagination(
                      onPageChanged: (int pageNumber) {
                        //do somthing for selected page
                        setState(() {
                          selectedPageNumber = pageNumber;
                        });
                      },
                      pageTotal: meta.pagination!.pageCount!,
                      pageInit:
                          selectedPageNumber, // picked number when init page
                      colorPrimary: AppColors.primaryColor,
                      colorSub: AppColors.backgroundColor3,
                    )
                  : Container(),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class ItemPesananMobile extends StatelessWidget {
  final Data pesananUser;
  const ItemPesananMobile({super.key, required this.pesananUser});

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Text(
                    'Pesanan : #${pesananUser.attributes!.nomorPermintaan ?? " ---"}',
                    style: AppTheme.primaryTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  'Tanggal : ${AppMethods.date(pesananUser.attributes!.createdAt!)}',
                  style: AppTheme.softgreyTextStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Status : ${pesananUser.attributes!.status!}',
                  style: pesananUser.attributes!.status == 'Selesai'
                      ? AppTheme.greenTextStyle
                      : AppTheme.redTextStyle,
                  textAlign: TextAlign.center,
                ),
                RichText(
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
              ],
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
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ],
    );
  }
}

class DetailPesananSectionMobile extends StatefulWidget {
  const DetailPesananSectionMobile({super.key});

  @override
  State<DetailPesananSectionMobile> createState() =>
      _DetailPesananSectionMobileState();
}

class _DetailPesananSectionMobileState
    extends State<DetailPesananSectionMobile> {
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
              if (status == "Permintaan Masuk") ...[
                const StatusWidget(
                    message:
                        'Permintaan anda berhasil kami terima. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses.'),
              ] else if (status == "Permintaan Disetujui") ...[
                const StatusWidget(
                    message:
                        'Permintaan anda berhasil kami terima. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses'),
                const StatusWidget(
                    message: 'Permintaan anda telah disetujui oleh admin'),
              ] else if (status == "Permintaan Ditolak") ...[
                const StatusWidget(
                    message:
                        'Permintaan anda berhasil kami terima. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses'),
                const StatusWidget(
                    message: 'Permintaan anda telah ditolak oleh admin'),
              ] else if (status == "Menunggu pembayaran") ...[
                const StatusWidget(
                    message:
                        'Permintaan anda berhasil kami terima. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses'),
                const StatusWidget(
                    message: 'Permintaan anda telah disetujui oleh admin'),
                StatusWidget(
                    message:
                        'Pesanan sekarang berstatus $status. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
              ] else if (status == "Permintaan Telah Dibayarkan") ...[
                const StatusWidget(
                    message:
                        'Permintaan anda berhasil kami terima. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses'),
                const StatusWidget(
                    message: 'Permintaan anda telah disetujui oleh admin'),
                const StatusWidget(
                    message:
                        'Pesanan sekarang berstatus Menunggu Pembayaran. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
                StatusWidget(message: 'Status $status'),
              ] else if (status == "Permintaan Selesai") ...[
                const StatusWidget(
                    message:
                        'Permintaan anda berhasil kami terima. Harap upload surat permintaan terlebih dahulu untuk melanjutkan proses'),
                const StatusWidget(
                    message: 'Permintaan anda telah disetujui oleh admin'),
                const StatusWidget(
                    message:
                        'Pesanan sekarang berstatus Menunggu Pembayaran. Silahkan upload bukti pembayaran dengan kode billing yang telah diberikan'),
                const StatusWidget(
                    message: 'Status Permintaan Telah Dibayarkan'),
                StatusWidget(message: '$status'),
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
        ItemDetailPesananMobile(
          title:
              '${permintaanController.dataPermintaan.attributes!.layanan!.attributes!.judul} x ${permintaanController.dataPermintaan.attributes!.kuantitas}',
          price: AppMethods.currency(
              permintaanController.dataPermintaan.attributes!.total.toString()),
        ),
        ItemDetailPesananMobile(
          title: 'Tipe Pesanan',
          price:
              permintaanController.dataPermintaan.attributes!.komersial == true
                  ? 'Komersial'
                  : 'Free',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: permintaanController.dataPermintaan.attributes!.metadata
                  ?.map(
                    (item) => ItemDetailPesananMobile(
                      title: item.field.toString(),
                      price: item.data ??
                          'Tidak ada', // Menggunakan data dari setiap elemen
                    ),
                  )
                  .toList() ??
              [], // Menggunakan elvis operator untuk mengatasi jika metadata null
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
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing Pembayaran',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                ],
              )
            : Container(),
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
            : Container(),
        const SizedBox(height: 30),
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isi Kuesioner terlebih dahulu',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider()
                ],
              )
            : Container(),
        const SizedBox(height: 15),
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Row(
                children: [
                  PrimaryButton(
                      onTap: () {
                        openURLInNewTab(
                            'https://eskm.bmkg.go.id/survey/437783/0/2/2023-07/2023/0');
                      },
                      titleButton: 'Kuesioner e-SKM'),
                  const SizedBox(width: 10),
                  PrimaryButton(
                      onTap: () {
                        openURLInNewTab('https://forms.gle/LDCdWFMbMVuTwKuEA ');
                      },
                      titleButton: 'Kuesioner Survey Persepsi Korupsi'),
                ],
              )
            : Container(),
        const SizedBox(height: 30),
        permintaanController
                    .dataPermintaan.attributes!.billingPembayaran!.data !=
                null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              )
            : Container(),
        const SizedBox(height: 15),
        permintaanController.dataPermintaan.attributes!.buktiPembayaran!.data !=
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
                          '${Constant.host}${permintaanController.dataPermintaan.attributes!.buktiPembayaran!.data!.attributes!.url}');
                    },
                    child: Text(
                      permintaanController.dataPermintaan.attributes!
                          .buktiPembayaran!.data!.attributes!.name
                          .toString(),
                      style: AppTheme.primaryTextStyle,
                    ),
                  ),
                ],
              )
            : permintaanController
                        .dataPermintaan.attributes!.billingPembayaran!.data !=
                    null
                ? SecondaryButton(
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
                  )
                : Container(),
        const SizedBox(height: 30),
        permintaanController
                    .dataPermintaan.attributes!.dokumenPermintaan!.data !=
                null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dokumen Permintaan',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                ],
              )
            : Container(),
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

  Widget ItemDetailPesananMobile(
      {required String title, required String price}) {
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
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  price,
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    letterSpacing: 1.1,
                  ),
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

class StatusWidgetMobile extends StatelessWidget {
  final String message;
  const StatusWidgetMobile({
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
