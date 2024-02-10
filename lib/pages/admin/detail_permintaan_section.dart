part of '../pages.dart';

class DetailPermintaanSection extends StatefulWidget {
  const DetailPermintaanSection({Key? key}) : super(key: key);

  @override
  State<DetailPermintaanSection> createState() =>
      _DetailPermintaanSectionState();
}

class _DetailPermintaanSectionState extends State<DetailPermintaanSection> {
  @override
  Widget build(BuildContext context) {
    final adminController = context.watch<AdminController>();
    final permintaanController = context.watch<PermintaanController>();
    final dataPermintaan = permintaanController.permintaanAdmin.attributes!;

    void openURLInNewTab(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    uploadFileBillingPembayaran() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'png', 'jpeg'],
      );

      final resultUploadFile = await CheckoutService.uploadFile(
        result!.files.first.bytes,
        result.files.first.name,
        dataPermintaan.layanan!.id.toString(),
        'billing_pembayaran',
      );

      if (resultUploadFile['success'] == true) {
        int? idFileUpload = resultUploadFile['idFileUpload'];
        final data = {
          "data": {
            "billing_pembayaran": idFileUpload,
          }
        };
        final update = await PermintaanService.updatePermintaan(
            permintaanController.permintaanAdmin.id.toString(), data);
        if (update) {
          // ignore: use_build_context_synchronously
          CoolAlert.show(
            context: context,
            width: MediaQuery.of(context).size.width * 0.3,
            type: CoolAlertType.success,
            text: 'Billing pembayaran berhasil diupload',
          ).then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/admin', (route) => false);
            adminController.pickMenu('Permintaan Data Masuk', 1);
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
    }

    uploadFileDokumenPermintaan() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'png', 'jpeg'],
      );

      final resultUploadFile = await CheckoutService.uploadFile(
        result!.files.first.bytes,
        result.files.first.name,
        dataPermintaan.layanan!.id.toString(),
        'data_permintaan',
      );

      if (resultUploadFile['success'] == true) {
        int? idFileUpload = resultUploadFile['idFileUpload'];
        final data = {
          "data": {
            "dokumen_permintaan": idFileUpload,
          }
        };
        final update = await PermintaanService.updatePermintaan(
            permintaanController.permintaanAdmin.id.toString(), data);
        if (update) {
          // ignore: use_build_context_synchronously
          CoolAlert.show(
            context: context,
            width: MediaQuery.of(context).size.width * 0.3,
            type: CoolAlertType.success,
            text: 'Data permintaan berhasil diupload',
          ).then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/admin', (route) => false);
            adminController.pickMenu('Permintaan Data Masuk', 1);
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
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.backgroundColor3,
              ),
              child: InkWell(
                onTap: () =>
                    adminController.pickMenu('Permintaan Data Masuk', 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primaryColor),
                    const SizedBox(width: 5),
                    Text(
                      'Kembali',
                      style: AppTheme.primaryTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Kode Pesanan : ",
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.medium,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  dataPermintaan.nomorPermintaan.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.medium,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  dataPermintaan.layanan!.attributes!.judul.toString(),
                  style: AppTheme.blackTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  dataPermintaan.status.toString(),
                  style: AppTheme.greenTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InformasiPesanan(dataPermintaan),
                      const SizedBox(height: 15),
                      InformasiPemesan(dataPermintaan),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BerkasPemesan(
                          dataPermintaan,
                          openURLInNewTab,
                          uploadFileBillingPembayaran,
                          uploadFileDokumenPermintaan),
                      const SizedBox(height: 15),
                      PembaharuanData(
                          permintaanController, context, adminController),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container PembaharuanData(PermintaanController permintaanController,
      BuildContext context, AdminController adminController) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundColor2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Perbarui Data',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text('Status', style: AppTheme.blackTextStyle),
            ],
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: permintaanController.selectedStatus,
            onChanged: (String? value) {
              if (value != null) {
                permintaanController.setSelectedStatus(value);
              }
            },
            decoration: InputDecoration(
              hintStyle: AppTheme.greyTextStyle.copyWith(
                fontSize: 12,
              ),
              isDense: true,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.greyColor, width: 2),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            items: permintaanController.statuses.map((status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status.toString()),
              );
            }).toList(),
          ),
          const SizedBox(height: 15),
          CustomFormUser(
            controller: permintaanController.nomorBillingController,
            title: 'Kode Billing',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onTap: () async {
              String billing = permintaanController
                  .permintaanAdmin.attributes!.kodeBilling
                  .toString();
              final data = {
                "data": {
                  "kode_billing": permintaanController
                          .nomorBillingController.text.isNotEmpty
                      ? permintaanController.nomorBillingController.text
                      : billing,
                  "status": permintaanController.selectedStatus ??
                      permintaanController.permintaanAdmin.attributes!.status,
                },
              };
              final result = await PermintaanService.updatePermintaan(
                  permintaanController.permintaanAdmin.id.toString(), data);
              if (result == true) {
                // ignore: use_build_context_synchronously
                CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        width: MediaQuery.of(context).size.width * 0.3,
                        text: "Data permintaan berhasil diperbaharui!")
                    .then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                          context, '/admin', (route) => false)
                      .then((value) =>
                          adminController.pickMenu('Permintaan Data Masuk', 1));
                });
              } else {
                // ignore: use_build_context_synchronously
                CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        width: MediaQuery.of(context).size.width * 0.3,
                        text: "Gagal menghapus data, coba lagi!")
                    .then(
                  (value) => Navigator.pop(context),
                );
              }
            },
            titleButton: 'Perbarui Data',
          ),
        ],
      ),
    );
  }

  Container BerkasPemesan(
      listPermintaanModelAdmin.Attributes dataPermintaan,
      void openURLInNewTab(String url),
      Future<Null> uploadFileBillingPembayaran(),
      Future<Null> uploadFileDokumenPermintaan()) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundColor2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berkas Pemesan',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          // Surat Permintaan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Surat Permintaan',
                style: AppTheme.greyTextStyle.copyWith(height: 1.5),
              ),
              dataPermintaan.suratPermintaan!.data != null
                  ? InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${dataPermintaan.suratPermintaan!.data!.attributes!.url}');
                      },
                      child: Text(
                        'Download',
                        style: AppTheme.primaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Text(
                      'Belum ada Surat Permintaan',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 20),
          // Billing Pembayaran
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Billing Pembayaran',
                style: AppTheme.greyTextStyle.copyWith(height: 1.5),
              ),
              dataPermintaan.billingPembayaran!.data != null
                  ? InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${dataPermintaan.suratPermintaan!.data!.attributes!.url}');
                      },
                      child: Text(
                        'Download',
                        style: AppTheme.primaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : SecondaryButton(
                      onTap: uploadFileBillingPembayaran,
                      titleButton: 'Pilih dan Upload',
                      fontSize: 14,
                    ),
            ],
          ),
          const SizedBox(height: 20),
          // Bukti Pembayaran
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bukti Pembayaran',
                style: AppTheme.greyTextStyle.copyWith(height: 1.5),
              ),
              dataPermintaan.buktiPembayaran!.data != null
                  ? InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${dataPermintaan.buktiPembayaran!.data!.attributes!.url}');
                      },
                      child: Text(
                        'Download',
                        style: AppTheme.primaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Text(
                      'Belum ada Bukti Pembayaran',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 20),
          // Dokumen Pembayaran
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dokumen Permintaan',
                style: AppTheme.greyTextStyle.copyWith(height: 1.5),
              ),
              dataPermintaan.dokumenPermintaan!.data != null
                  ? InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${dataPermintaan.dokumenPermintaan!.data!.attributes!.url}');
                      },
                      child: Text(
                        'Download',
                        style: AppTheme.primaryTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : SecondaryButton(
                      onTap: uploadFileDokumenPermintaan,
                      titleButton: 'Pilih dan Upload',
                      fontSize: 14,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Container InformasiPemesan(
      listPermintaanModelAdmin.Attributes dataPermintaan) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundColor2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pemesan',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(dataPermintaan.nama.toString(),
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Alamat ${dataPermintaan.alamat}',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Kecamatan ${dataPermintaan.kecamatan}',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Kota ${dataPermintaan.kota}',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Provinsi ${dataPermintaan.provinsi}',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('No Telephone ${dataPermintaan.telepon}',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
          Text('Email ${dataPermintaan.email}',
              style: AppTheme.greyTextStyle.copyWith(height: 1.5)),
        ],
      ),
    );
  }

  Container InformasiPesanan(
      listPermintaanModelAdmin.Attributes dataPermintaan) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundColor2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pesanan ${dataPermintaan.kodeBilling}',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          dataPermintaan.kodeBilling != null
              ? ItemDetailPesanan(
                  title: 'Nomor Billing',
                  data: dataPermintaan.kodeBilling.toString())
              : Container(),
          ItemDetailPesanan(
              title: 'Dibuat pada',
              data: AppMethods.date(dataPermintaan.createdAt.toString())
                  .toString()),
          ItemDetailPesanan(
              title: 'Terakhir diperbaharui',
              data: AppMethods.date(dataPermintaan.updatedAt.toString())
                  .toString()),
          ItemDetailPesanan(
              title: 'Layanan',
              data: dataPermintaan.layanan!.attributes!.judul.toString()),
          ItemDetailPesanan(
              title: 'Kuantitas', data: dataPermintaan.kuantitas.toString()),
          ItemDetailPesanan(
              title: 'Tipe Pesanan',
              data: dataPermintaan.komersial == true ? 'Komersial' : 'Free'),
          ItemDetailPesanan(
              title: 'Harga Satuan',
              data:
                  '${AppMethods.currency(dataPermintaan.layanan!.attributes!.harga.toString())} ${dataPermintaan.layanan!.attributes!.satuan}'),
          ItemDetailPesanan(
              title: 'Total Harga',
              data: AppMethods.currency(dataPermintaan.total.toString())
                  .toString()),
          Text(
            'Metadata',
            style: AppTheme.blackTextStyle.copyWith(
              fontWeight: AppTheme.bold,
              letterSpacing: 1.1,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: dataPermintaan.metadata!.length,
            itemBuilder: (context, index) {
              return ItemDetailPesanan(
                  title: dataPermintaan.metadata![index].field.toString(),
                  data: dataPermintaan.metadata![index].data.toString());
            },
          ),
        ],
      ),
    );
  }

  Widget ItemDetailPesanan({required String title, required String data}) {
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
                title == 'Catatan User' && data.isEmpty
                    ? 'Tidak ada catatan'
                    : data,
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
