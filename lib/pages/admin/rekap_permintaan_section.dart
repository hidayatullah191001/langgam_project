part of '../pages.dart';

class RekapPermintaanSection extends StatefulWidget {
  const RekapPermintaanSection({Key? key}) : super(key: key);

  @override
  State<RekapPermintaanSection> createState() => _RekapPermintaanSectionState();
}

class _RekapPermintaanSectionState extends State<RekapPermintaanSection> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController finishDateController = TextEditingController();
  TextEditingController countDataController = TextEditingController();
  bool isSubmit = false;

  List<String> status = [
    'Semua Permintaan',
    'Menunggu Persetujuan',
    'Verifikasi Persyaratan',
    'Menunggu Pembayaran',
    'Verifikasi Pembayaran',
    'Sedang Diproses',
    'Selesai',
  ];

  String _selectedStatus = 'Semua Permintaan';
  int _selectedIndex = 0;
  int selectedPageNumber = 1;

  Future<void> toXLSX(
      List<listPermintaanModelAdmin.PermintaanAdminData> data) async {
    List<String> row = [
      'Nomor Permintaan',
      'Pemesan',
      'Tanggal Pemesanan',
      'Item Permintaan',
      'Kuantitas',
      'Total',
      'Status',
    ];

    if (data != null) {
      if (data.isNotEmpty) {
        var simplexlsx = SimpleXLSX();
        simplexlsx.sheetName = 'sheet';

        //add data
        var idx = 0;
        data.forEach((item) {
          List<String> column = [
            item.attributes!.nomorPermintaan.toString(),
            item.attributes!.nama.toString(),
            AppMethods.date(item.attributes!.createdAt.toString()),
            item.attributes!.layanan!.attributes!.judul.toString(),
            item.attributes!.kuantitas.toString(),
            AppMethods.currency(item.attributes!.total.toString()),
            item.attributes!.status.toString(),
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
              "Rekap Permintan ${startDateController.text} - ${finishDateController.text ?? ''}.xlsx")
          ..click();
        html.Url.revokeObjectUrl(url);
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
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MobileView(context),
              );
            } else {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20, right: 40),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: WebView(context),
              );
            }
          },
        ),
      );
    });
  }

  Widget WebView(BuildContext context) {
    final permintaanController = context.watch<PermintaanController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.backgroundColor3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rekap Data Permintaan',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
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
                                isSubmit = false;
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
                                isSubmit = false;
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomFormUser(
                  title: 'Jumlah Banyak Data',
                  controller: countDataController,
                  keyboardType: TextInputType.number,
                  hintText: 'Default 25 data',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    PrimaryButton(
                      onTap: () {
                        setState(() {
                          isSubmit = true;
                        });
                        context
                            .read<PermintaanController>()
                            .getAllPermintaanByDate(
                              startDateController.text,
                              finishDateController.text,
                              page: selectedPageNumber,
                              pageSize: countDataController.text.isEmpty
                                  ? 25
                                  : int.parse(countDataController.text),
                            );
                      },
                      titleButton: 'SUBMIT',
                    ),
                    const SizedBox(width: 10),
                    DangerButton(
                      onTap: () {
                        setState(() {
                          startDateController.text = '';
                          finishDateController.text = '';
                          countDataController.text = '';
                          isSubmit = false;
                        });
                        permintaanController.setDataPermintaanAdmin(null);
                      },
                      titleButton: 'CLEAR',
                    ),
                    const SizedBox(width: 20),
                    isSubmit
                        ? SuccessButton(
                            onTap: () =>
                                toXLSX(permintaanController.permintaan.data!),
                            titleButton: 'EKSPOR EXCEL',
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          isSubmit
              ? Consumer<PermintaanController>(
                  builder: (context, controller, child) {
                    if (controller.dataState == DataState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.dataState == DataState.error) {
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

                    final permintaan = controller.permintaan;
                    if (permintaan.data!.length < 1) {
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
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: permintaan.data!.length.toInt(),
                          itemBuilder: (context, index) {
                            return ItemPesananAdminWidget(
                              pesananUser: permintaan.data![index],
                            );
                          },
                        ),
                        permintaan.data!.length > 0
                            ? NumberPagination(
                                onPageChanged: (int pageNumber) {
                                  //do somthing for selected page
                                  setState(() {
                                    selectedPageNumber = pageNumber;
                                  });
                                  context
                                      .read<PermintaanController>()
                                      .getAllPermintaanByDate(
                                        startDateController.text,
                                        finishDateController.text,
                                        page: selectedPageNumber,
                                        pageSize:
                                            countDataController.text.isEmpty
                                                ? 25
                                                : int.parse(
                                                    countDataController.text),
                                      );
                                },
                                pageTotal:
                                    permintaan.meta!.pagination!.pageCount!,
                                pageInit:
                                    selectedPageNumber, // picked number when init page
                                colorPrimary: AppColors.primaryColor,
                                colorSub: AppColors.backgroundColor3,
                              )
                            : Container(),
                      ],
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }

  Widget MobileView(BuildContext context) {
    final permintaanController = context.watch<PermintaanController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.backgroundColor3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rekap Data Permintaan',
                  style: AppTheme.blackTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                CustomFormUser(
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
                          isSubmit = false;
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomFormUser(
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
                          isSubmit = false;
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                CustomFormUser(
                  title: 'Jumlah Banyak Data',
                  controller: countDataController,
                  keyboardType: TextInputType.number,
                  hintText: 'Default 25 data',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    PrimaryButton(
                      onTap: () {
                        setState(() {
                          isSubmit = true;
                        });
                        context
                            .read<PermintaanController>()
                            .getAllPermintaanByDate(
                              startDateController.text,
                              finishDateController.text,
                              page: selectedPageNumber,
                              pageSize: countDataController.text.isEmpty
                                  ? 25
                                  : int.parse(countDataController.text),
                            );
                      },
                      titleButton: 'SUBMIT',
                    ),
                    const SizedBox(width: 10),
                    DangerButton(
                      onTap: () {
                        setState(() {
                          startDateController.text = '';
                          finishDateController.text = '';
                          countDataController.text = '';
                          isSubmit = false;
                        });
                        permintaanController.setDataPermintaanAdmin(null);
                      },
                      titleButton: 'CLEAR',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                isSubmit
                    ? SuccessButton(
                        onTap: () =>
                            toXLSX(permintaanController.permintaan.data!),
                        titleButton: 'EKSPOR EXCEL',
                      )
                    : Container(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          isSubmit
              ? Consumer<PermintaanController>(
                  builder: (context, controller, child) {
                    if (controller.dataState == DataState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.dataState == DataState.error) {
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

                    final permintaan = controller.permintaan;
                    if (permintaan.data!.length < 1) {
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
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: permintaan.data!.length.toInt(),
                          itemBuilder: (context, index) {
                            return ItemPesananAdminMobileWidget(
                              pesananUser: permintaan.data![index],
                            );
                          },
                        ),
                        permintaan.data!.length > 0
                            ? NumberPagination(
                                onPageChanged: (int pageNumber) {
                                  //do somthing for selected page
                                  setState(() {
                                    selectedPageNumber = pageNumber;
                                  });
                                  context
                                      .read<PermintaanController>()
                                      .getAllPermintaanByDate(
                                        startDateController.text,
                                        finishDateController.text,
                                        page: selectedPageNumber,
                                        pageSize:
                                            countDataController.text.isEmpty
                                                ? 25
                                                : int.parse(
                                                    countDataController.text),
                                      );
                                },
                                pageTotal:
                                    permintaan.meta!.pagination!.pageCount!,
                                pageInit:
                                    selectedPageNumber, // picked number when init page
                                colorPrimary: AppColors.primaryColor,
                                colorSub: AppColors.backgroundColor3,
                              )
                            : Container(),
                      ],
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
