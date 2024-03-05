part of '../pages.dart';

class LogbookSection extends StatefulWidget {
  const LogbookSection({Key? key}) : super(key: key);

  @override
  State<LogbookSection> createState() => _LogbookSectionState();
}

class _LogbookSectionState extends State<LogbookSection> {
  int selectedPageNumber = 1;
  TextEditingController startDateController = TextEditingController();
  TextEditingController finishDateController = TextEditingController();
  TextEditingController countDataController = TextEditingController();

  Future<void> toXLSX(List<LogbookData> data) async {
    List<String> row = [
      'Perihal Permohonan',
      'Nama Pemohon',
      'Nomor Telepon',
      'Waktu Pengerjaan',
      'Pembayaran',
      'Waktu Pengambilan',
      'Nama Petugas',
      'Dibuat Pada',
      'Diperbarui Pada',
    ];

    if (data.isNotEmpty) {
      if (data.isNotEmpty) {
        var simplexlsx = SimpleXLSX();
        simplexlsx.sheetName = 'sheet';

        //add data
        var idx = 0;
        data.forEach((item) {
          List<String> column = [
            item.attributes!.perihalPermohonan.toString(),
            item.attributes!.namaPemohon.toString(),
            item.attributes!.nomorTelepon.toString(),
            item.attributes!.waktuPengerjaan.toString(),
            AppMethods.currency(item.attributes!.pembayaran.toString()),
            item.attributes!.waktuPengambilan.toString(),
            item.attributes!.namaPetugas.toString(),
            AppMethods.date(item.attributes!.createdAt.toString()),
            AppMethods.date(item.attributes!.updatedAt.toString()),
          ];

          if (idx == 0) {
            //add titles
            simplexlsx.addRow(row);
          }
          {
            //add values
            simplexlsx.addRow(column);
          }
          idx++;
        });

        final bytes = simplexlsx.build();

        final blob = html.Blob([
          Uint8List.fromList(bytes)
        ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download",
              "Rekap Logbook ${startDateController.text} - ${finishDateController.text}.xlsx")
          ..click();
        html.Url.revokeObjectUrl(url);
        startDateController.text = '';
        finishDateController.text = '';
        countDataController.text = '';
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool mobile = false;
      if (constraints.maxWidth < 800) {
        mobile = true;
      } else {
        mobile == false;
      }
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20, right: mobile ? 10 : 40),
        padding: EdgeInsets.all(mobile ? 20 : 30),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 800) {
              return MobileView(context);
            } else {
              return WebView(context);
            }
          },
        ),
      );
    });
  }

  Widget WebView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          PrimaryButton(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: ModalCreateLogbook(context, false),
                  );
                },
              );
            },
            titleButton: 'Buat Logbook',
          ),
          const SizedBox(width: 10),
          SuccessButton(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: ModalPrintLogbook(context, false),
                  );
                },
              );
            },
            titleButton: 'Cetak Logbook',
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future:
                  LogbookService.getAllLogbookAdmin(page: selectedPageNumber),
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
                          'Data tidak ditemukan',
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
                  LogbookModel model = snapshot.data!;
                  if (model.data!.length < 1) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            'lottie/empty_cart.json',
                            width: 150,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Data tidak ditemukan',
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
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: model.data!.length,
                        itemBuilder: (context, index) {
                          final logbook = model.data![index].attributes!;
                          return ItemLogbookWidget(
                            logbook,
                            model.data![index].id.toString(),
                          );
                        },
                      ),
                      model.data!.length > 0
                          ? NumberPagination(
                              onPageChanged: (int pageNumber) {
                                //do somthing for selected page
                                setState(() {
                                  selectedPageNumber = pageNumber;
                                });
                              },
                              pageTotal: model.meta!.pagination!.pageCount!,
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
            ),
          ),
        )
      ],
    );
  }

  Widget MobileView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            PrimaryButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: ModalCreateLogbook(context, true),
                    );
                  },
                );
              },
              titleButton: 'Buat Logbook',
            ),
            const SizedBox(width: 10),
            SuccessButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: ModalPrintLogbook(context, true),
                    );
                  },
                );
              },
              titleButton: 'Cetak Logbook',
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: LogbookService.getAllLogbookAdmin(page: selectedPageNumber),
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
                        'Data tidak ditemukan',
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
                LogbookModel model = snapshot.data!;
                if (model.data!.length < 1) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          'lottie/empty_cart.json',
                          width: 150,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Data tidak ditemukan',
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
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        final logbook = model.data![index].attributes!;
                        return ItemLogbookMobileWidget(
                          logbook,
                          model.data![index].id.toString(),
                        );
                      },
                    ),
                    model.data!.length > 0
                        ? NumberPagination(
                            onPageChanged: (int pageNumber) {
                              //do somthing for selected page
                              setState(() {
                                selectedPageNumber = pageNumber;
                              });
                            },
                            pageTotal: model.meta!.pagination!.pageCount!,
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
          )
        ],
      ),
    );
  }

  Widget ModalViewLogbook(BuildContext context, LogbookAttributes logbook,
      {bool isMobile = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemDetailLogbookWidget(
                title: 'Nama Petugas',
                value: logbook.namaPetugas.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Perihal Permohonan',
                value: logbook.perihalPermohonan.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Nama Pemohon',
                value: logbook.namaPemohon.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Nomor Telepon',
                value: logbook.nomorTelepon.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Waktu Pengerjaan',
                value: logbook.waktuPengerjaan.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Pembayaran',
                value: AppMethods.currency(logbook.pembayaran.toString()),
                isMobile: isMobile),
            const SizedBox(height: 10),
            // ItemDetailLogbookWidget(
            //     title: 'Status', value: logbook.status.toString()),
            // const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Waktu Pengambilan',
                value: logbook.waktuPengambilan.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Keterangan',
                value: logbook.keterangan.toString(),
                isMobile: isMobile),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Dibuat pada',
                value: AppMethods.date(logbook.createdAt.toString()),
                isMobile: isMobile),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget ItemDetailLogbookWidget(
      {required String title, required String value, bool isMobile = false}) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.blackTextStyle),
          const SizedBox(width: 10),
          Text(
            value,
            style: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTheme.blackTextStyle),
          const SizedBox(width: 10),
          Text(
            value,
            style: AppTheme.primaryTextStyle.copyWith(
              fontWeight: AppTheme.bold,
            ),
          ),
        ],
      );
    }
  }

  Widget ModalCreateLogbook(BuildContext context, bool isMobile) {
    final logbookController = context.watch<LogbookController>();
    logbookController.setEmptyVariable();
    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormUser(
              controller: logbookController.namaPetugasController,
              title: 'Nama petugas',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            // Perihal Permohonan
            Row(
              children: [
                Text('Perihal permohonan ', style: AppTheme.blackTextStyle),
                Text(
                  '*',
                  style: AppTheme.blackTextStyle.copyWith(
                    color: AppColors.dangerColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: logbookController.selectedPerihalPermohonan,
              onChanged: (String? value) {
                logbookController.setSelectedPerihalPermohonan(value!);
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
              items: logbookController.perihalPermohonans.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.namaPemohanController,
              title: 'Nama pemohon',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.nomorTeleponController,
              title: 'Nomor telepon',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.waktuPengerjaanController,
              title: 'Waktu pengerjaan',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.pembayaranController,
              title: 'Total Pembayaran',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text('Status ', style: AppTheme.blackTextStyle),
            //     Text(
            //       '*',
            //       style: AppTheme.blackTextStyle.copyWith(
            //         color: AppColors.dangerColor,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5),
            // // Status
            // DropdownButtonFormField<String>(
            //   value: logbookController.selectedStatus,
            //   onChanged: (String? value) {
            //     logbookController.setSelectedStatus(value!);
            //   },
            //   decoration: InputDecoration(
            //     hintStyle: AppTheme.greyTextStyle.copyWith(
            //       fontSize: 12,
            //     ),
            //     isDense: true,
            //     border: OutlineInputBorder(
            //       borderSide:
            //           const BorderSide(color: AppColors.greyColor, width: 2),
            //       borderRadius: BorderRadius.circular(7),
            //     ),
            //   ),
            //   items: logbookController.statuses.map((status) {
            //     return DropdownMenuItem<String>(
            //       value: status,
            //       child: Text(status.toString()),
            //     );
            //   }).toList(),
            // ),
            // const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.waktuPengambilan,
              title: 'Waktu Pengambilan',
              isMandatory: true,
              keyboardType: TextInputType.none,
              onTap: () async {
                DateTime? result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023, 01, 01),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (result != null) {
                  logbookController.waktuPengambilan.text =
                      DateFormat('yyyy-MM-dd').format(result);
                }
              },
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.keteranganController,
              title: 'Keterangan',
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onTap: () {
                logbookController.createLogbookAdmin(context);
                context.pop();
                setState(() {});
              },
              titleButton: 'SUBMIT',
            ),
          ],
        ),
      ),
    );
  }

  Widget ModalEditLogbook(BuildContext context, bool isMobile,
      LogbookAttributes logbook, String idLogbook) {
    final logbookController = context.watch<LogbookController>();
    logbookController.setDefaultUpdateValue(logbook);
    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormUser(
              controller: logbookController.namaPetugasController,
              title: 'Nama petugas',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            // Perihal Permohonan
            Row(
              children: [
                Text('Perihal permohonan ', style: AppTheme.blackTextStyle),
                Text(
                  '*',
                  style: AppTheme.blackTextStyle.copyWith(
                    color: AppColors.dangerColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: logbookController.selectedPerihalPermohonan,
              onChanged: (String? value) {
                logbookController.setSelectedPerihalPermohonan(value!);
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
              items: logbookController.perihalPermohonans.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.namaPemohanController,
              title: 'Nama pemohon',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.nomorTeleponController,
              title: 'Nomor telepon',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.waktuPengerjaanController,
              title: 'Waktu pengerjaan',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.pembayaranController,
              title: 'Total Pembayaran',
              isMandatory: true,
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text('Status ', style: AppTheme.blackTextStyle),
            //     Text(
            //       '*',
            //       style: AppTheme.blackTextStyle.copyWith(
            //         color: AppColors.dangerColor,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 5),
            // // Status
            // DropdownButtonFormField<String>(
            //   value: logbookController.selectedStatus,
            //   onChanged: (String? value) {
            //     // logbookController.statusController.text = value!;
            //     logbookController.setSelectedStatus(value!);
            //   },
            //   decoration: InputDecoration(
            //     hintStyle: AppTheme.greyTextStyle.copyWith(
            //       fontSize: 12,
            //     ),
            //     isDense: true,
            //     border: OutlineInputBorder(
            //       borderSide:
            //           const BorderSide(color: AppColors.greyColor, width: 2),
            //       borderRadius: BorderRadius.circular(7),
            //     ),
            //   ),
            //   items: logbookController.statuses.map((status) {
            //     return DropdownMenuItem<String>(
            //       value: status,
            //       child: Text(status.toString()),
            //     );
            //   }).toList(),
            // ),
            // const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.waktuPengambilan,
              title: 'Waktu Pengambilan',
              isMandatory: true,
              keyboardType: TextInputType.none,
              onTap: () async {
                DateTime? result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023, 01, 01),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                if (result != null) {
                  logbookController.waktuPengambilan.text =
                      DateFormat('yyyy-MM-dd').format(result);
                }
              },
            ),
            const SizedBox(height: 10),
            CustomFormUser(
              controller: logbookController.keteranganController,
              title: 'Keterangan',
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onTap: () {
                logbookController.updateLogbookAdmin(context, idLogbook);
                context.pop();
                setState(() {});
              },
              titleButton: 'UPDATE',
            ),
          ],
        ),
      ),
    );
  }

  Widget ItemLogbookWidget(LogbookAttributes logbook, String id) {
    final logbookController = context.watch<LogbookController>();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundColor2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Petugas',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.namaPetugas ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perihal Permohohanan',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.perihalPermohonan ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Pemohon',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.namaPemohon ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       'Status',
          //       style: AppTheme.greyTextStyle
          //           .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
          //     ),
          //     const SizedBox(height: 10),
          //     Text(
          //       '${logbook.status ?? 'Tidak ada'}',
          //       style: AppTheme.primaryTextStyle
          //           .copyWith(fontWeight: AppTheme.bold),
          //     ),
          //   ],
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Waktu Pengerjaan',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.waktuPengerjaan ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: ModalViewLogbook(context, logbook),
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 18,
                  child: Icon(Icons.remove_red_eye_outlined,
                      size: 15, color: AppColors.whiteColor),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: ModalEditLogbook(context, true, logbook, id),
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.warningColor,
                  radius: 18,
                  child:
                      Icon(Icons.edit, size: 15, color: AppColors.whiteColor),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    width: MediaQuery.of(context).size.width * 0.3,
                    confirmBtnText: 'Hapus',
                    confirmBtnColor: AppColors.dangerColor,
                    cancelBtnText: 'Batal',
                    confirmBtnTextStyle: AppTheme.whiteTextStyle,
                    cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
                    text: 'Kamu yakin ingin menghapus data ini?',
                    showCancelBtn: true,
                    onConfirmBtnTap: () {
                      logbookController.deleteLogbookAdmin(context, id);
                      setState(() {});
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.dangerColor,
                  radius: 18,
                  child:
                      Icon(Icons.remove, size: 15, color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ItemLogbookMobileWidget(LogbookAttributes logbook, String id) {
    final logbookController = context.watch<LogbookController>();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.backgroundColor2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Petugas',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 5),
              Text(
                '${logbook.namaPetugas ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Perihal Permohohanan',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 5),
              Text(
                '${logbook.perihalPermohonan ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Nama Pemohon',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 5),
              Text(
                '${logbook.namaPemohon ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
              // const SizedBox(height: 5),
              // Text(
              //   'Status',
              //   style: AppTheme.greyTextStyle
              //       .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              // ),
              // const SizedBox(height: 10),
              // Text(
              //   '${logbook.status ?? 'Tidak ada'}',
              //   style: AppTheme.primaryTextStyle
              //       .copyWith(fontWeight: AppTheme.bold),
              // ),
              const SizedBox(height: 10),
              Text(
                'Waktu Pengerjaan',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.waktuPengerjaan ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child:
                            ModalViewLogbook(context, logbook, isMobile: true),
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 18,
                  child: Icon(Icons.remove_red_eye_outlined,
                      size: 15, color: AppColors.whiteColor),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: ModalEditLogbook(context, true, logbook, id),
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.warningColor,
                  radius: 18,
                  child:
                      Icon(Icons.edit, size: 15, color: AppColors.whiteColor),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    width: MediaQuery.of(context).size.width * 0.3,
                    confirmBtnText: 'Hapus',
                    confirmBtnColor: AppColors.dangerColor,
                    cancelBtnText: 'Batal',
                    confirmBtnTextStyle: AppTheme.whiteTextStyle,
                    cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
                    text: 'Kamu yakin ingin menghapus data ini?',
                    showCancelBtn: true,
                    onConfirmBtnTap: () {
                      logbookController.deleteLogbookAdmin(context, id);
                      context.pop();
                    },
                    onCancelBtnTap: () {
                      context.pop();
                    },
                  ).then((value) => setState(() {}));
                },
                child: const CircleAvatar(
                  backgroundColor: AppColors.dangerColor,
                  radius: 18,
                  child:
                      Icon(Icons.remove, size: 15, color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ModalPrintLogbook(BuildContext context, bool isMobile) {
    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomFormUser(
                  title: 'Start Date',
                  controller: startDateController,
                  keyboardType: TextInputType.none,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (result != null) {
                      setState(
                        () {
                          startDateController.text =
                              DateFormat('yyyy-MM-dd').format(result);
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomFormUser(
                  title: 'Finish Date',
                  controller: finishDateController,
                  keyboardType: TextInputType.none,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (result != null) {
                      setState(
                        () {
                          finishDateController.text =
                              DateFormat('yyyy-MM-dd').format(result);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomFormUser(
            title: 'Jumlah Banyak Data',
            controller: countDataController,
            keyboardType: TextInputType.number,
            hintText: 'Default 25 data',
          ),
          const SizedBox(height: 20),
          SuccessButton(
            onTap: () async {
              LogbookModel logbook = await LogbookService.getAllLogbookByDate(
                  startDate: startDateController.text,
                  finishDate: finishDateController.text,
                  pageSize: countDataController.text.isEmpty
                      ? 25
                      : int.parse(countDataController.text));
              final data = logbook.data;
              toXLSX(data!);
            },
            titleButton: "Cetak Excel",
          ),
        ],
      ),
    );
  }
}

// class ItemLogbookMobileWidget extends StatelessWidget {
//   const ItemLogbookMobileWidget({
//     super.key,
//     required this.logbook,
//   });

//   final LogbookAttributes logbook;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: AppColors.backgroundColor2,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Perihal Permohohanan',
//                 style: AppTheme.greyTextStyle
//                     .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 '${logbook.perihalPermohonan ?? 'Tidak ada'}',
//                 style: AppTheme.primaryTextStyle
//                     .copyWith(fontWeight: AppTheme.bold),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'Nama Pemohon',
//                 style: AppTheme.greyTextStyle
//                     .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 '${logbook.namaPemohon ?? 'Tidak ada'}',
//                 style: AppTheme.primaryTextStyle
//                     .copyWith(fontWeight: AppTheme.bold),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'Status',
//                 style: AppTheme.greyTextStyle
//                     .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 '${logbook.status ?? 'Tidak ada'}',
//                 style: AppTheme.primaryTextStyle
//                     .copyWith(fontWeight: AppTheme.bold),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Waktu Pengerjaan',
//                 style: AppTheme.greyTextStyle
//                     .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 '${logbook.waktuPengerjaan ?? 'Tidak ada'}',
//                 style: AppTheme.primaryTextStyle
//                     .copyWith(fontWeight: AppTheme.bold),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {},
//                 child: const CircleAvatar(
//                   backgroundColor: AppColors.primaryColor,
//                   radius: 18,
//                   child: Icon(Icons.remove_red_eye_outlined,
//                       size: 15, color: AppColors.whiteColor),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               InkWell(
//                 onTap: () {},
//                 child: const CircleAvatar(
//                   backgroundColor: AppColors.warningColor,
//                   radius: 18,
//                   child:
//                       Icon(Icons.edit, size: 15, color: AppColors.whiteColor),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               InkWell(
//                 onTap: () {},
//                 child: const CircleAvatar(
//                   backgroundColor: AppColors.dangerColor,
//                   radius: 18,
//                   child:
//                       Icon(Icons.remove, size: 15, color: AppColors.whiteColor),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
