part of '../pages.dart';

class LogbookSection extends StatefulWidget {
  const LogbookSection({Key? key}) : super(key: key);

  @override
  State<LogbookSection> createState() => _LogbookSectionState();
}

class _LogbookSectionState extends State<LogbookSection> {
  int selectedPageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20, right: 40),
      padding: const EdgeInsets.all(30),
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
  }

  Widget WebView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  Widget ModalViewLogbook(BuildContext context, LogbookAttributes logbook) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemDetailLogbookWidget(
                title: 'Perihal Permohonan',
                value: logbook.perihalPermohonan.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Nama Pemohon', value: logbook.namaPemohon.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Nomor Telepon', value: logbook.nomorTelepon.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Waktu Pengerjaan',
                value: logbook.waktuPengerjaan.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Pembayaran', value: logbook.pembayaran.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Status', value: logbook.status.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Waktu Pengambilan',
                value: logbook.waktuPengambilan.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Keterangan', value: logbook.keterangan.toString()),
            const SizedBox(height: 10),
            ItemDetailLogbookWidget(
                title: 'Dibuat pada',
                value: AppMethods.date(logbook.createdAt.toString())),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Row ItemDetailLogbookWidget({required String title, required String value}) {
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

  Widget ModalCreateLogbook(BuildContext context, bool isMobile) {
    final logbookController = context.watch<LogbookController>();
    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.4
          : MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            // Perihal Permohonan
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
            Row(
              children: [
                Text('Keperluan ', style: AppTheme.blackTextStyle),
                Text(
                  '*',
                  style: AppTheme.blackTextStyle.copyWith(
                    color: AppColors.dangerColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Status
            DropdownButtonFormField<String>(
              value: logbookController.selectedStatus,
              onChanged: (String? value) {
                // logbookController.statusController.text = value!;
                logbookController.setSelectedStatus(value!);
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
              items: logbookController.statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
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
              isMandatory: true,
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
    if (logbook != null) {
      logbookController.setDefaultUpdateValue(logbook);
    }
    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.4
          : MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            // Perihal Permohonan
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
            Row(
              children: [
                Text('Keperluan ', style: AppTheme.blackTextStyle),
                Text(
                  '*',
                  style: AppTheme.blackTextStyle.copyWith(
                    color: AppColors.dangerColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Status
            DropdownButtonFormField<String>(
              value: logbookController.selectedStatus,
              onChanged: (String? value) {
                // logbookController.statusController.text = value!;
                logbookController.setSelectedStatus(value!);
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
              items: logbookController.statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
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
              isMandatory: true,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.status ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
            ],
          ),
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
                      context.pop();
                    },
                    onCancelBtnTap: () {
                      context.pop();
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
              const SizedBox(height: 5),
              Text(
                'Status',
                style: AppTheme.greyTextStyle
                    .copyWith(fontSize: 14, fontWeight: AppTheme.medium),
              ),
              const SizedBox(height: 10),
              Text(
                '${logbook.status ?? 'Tidak ada'}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
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
