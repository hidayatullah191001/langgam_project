part of '../pages.dart';

class PelayananMasukSection extends StatefulWidget {
  const PelayananMasukSection({Key? key}) : super(key: key);

  @override
  State<PelayananMasukSection> createState() => _PelayananMasukSectionState();
}

class _PelayananMasukSectionState extends State<PelayananMasukSection> {
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

  Widget MobileView(BuildContext) {
    return Column(
      children: [
        SizedBox(
          height: 35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: status.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    _selectedStatus = status[index];
                    print(_selectedStatus);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: _selectedIndex == index
                        ? AppColors.backgroundColor2
                        : Colors.transparent,
                  ),
                  child: Text(
                    status[index],
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder(
            future: _selectedStatus == 'Semua Permintaan'
                ? PermintaanService.getAllPermintaan()
                : PermintaanService.getAllPermintaanByStatus(_selectedStatus,
                    page: selectedPageNumber),
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
                listPermintaanModelAdmin.ListPermintaanModelAdmin model =
                    snapshot.data!;
                final meta = snapshot.data!.meta!;
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: model.data!.length.toInt(),
                        itemBuilder: (context, index) {
                          return ItemPesananAdminMobileWidget(
                            pesananUser: model.data![index],
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
                              pageTotal: meta.pagination!.pageCount!,
                              pageInit:
                                  selectedPageNumber, // picked number when init page
                              colorPrimary: AppColors.primaryColor,
                              colorSub: AppColors.backgroundColor3,
                            )
                          : Container(),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget WebView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.18,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: status.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    _selectedStatus = status[index];
                    print(_selectedStatus);
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: _selectedIndex == index
                        ? AppColors.backgroundColor2
                        : Colors.transparent,
                  ),
                  child: Text(
                    status[index],
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FutureBuilder(
            future: _selectedStatus == 'Semua Permintaan'
                ? PermintaanService.getAllPermintaan(page: selectedPageNumber)
                : PermintaanService.getAllPermintaanByStatus(_selectedStatus),
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
                listPermintaanModelAdmin.ListPermintaanModelAdmin model =
                    snapshot.data!;
                final meta = snapshot.data!.meta!;

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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: model.data!.length.toInt(),
                        itemBuilder: (context, index) {
                          return ItemPesananAdminWidget(
                            pesananUser: model.data![index],
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
                              pageTotal: meta.pagination!.pageCount!,
                              pageInit:
                                  selectedPageNumber, // picked number when init page
                              colorPrimary: AppColors.primaryColor,
                              colorSub: AppColors.backgroundColor3,
                            )
                          : Container(),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

class ItemPesananAdminWidget extends StatefulWidget {
  final listPermintaanModelAdmin.PermintaanAdminData pesananUser;
  const ItemPesananAdminWidget({
    super.key,
    required this.pesananUser,
  });

  @override
  State<ItemPesananAdminWidget> createState() => _ItemPesananAdminWidgetState();
}

class _ItemPesananAdminWidgetState extends State<ItemPesananAdminWidget> {
  void deletePermintaan(String idPermintaan) async {
    final result =
        await PermintaanService.deletePermintaanByAdmin(idPermintaan);
    if (result == true) {
      // ignore: use_build_context_synchronously
      AppMethods.successToast(context, 'Data permintaan berhasil dihapus');
      setState(() {});
    } else {
      // ignore: use_build_context_synchronously
      AppMethods.dangerToast(context, 'Gagal menghapus data, coba lagi');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AdminController>();
    final permintaanController = context.watch<PermintaanController>();

    print('data widget ${widget.pesananUser.attributes!.nomorPermintaan}');
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${widget.pesananUser.attributes!.nomorPermintaan}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor2,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.pesananUser.attributes!.status.toString(),
                  style: AppTheme.blackTextStyle
                      .copyWith(fontWeight: AppTheme.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  widget.pesananUser.attributes!.nama.toString(),
                  style: AppTheme.blackTextStyle
                      .copyWith(fontSize: 18, fontWeight: AppTheme.medium),
                ),
                Text(
                  'Dibuat pada ${AppMethods.date(widget.pesananUser.attributes!.createdAt.toString())}',
                  style: AppTheme.blackTextStyle.copyWith(fontSize: 12),
                ),
              ]),
              const SizedBox(height: 5),
              Expanded(
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            '${widget.pesananUser.attributes!.layanan == null ? '' : widget.pesananUser.attributes!.layanan!.attributes!.judul} ',
                        style: AppTheme.primaryTextStyle.copyWith(
                          fontWeight: AppTheme.bold,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  'untuk ${widget.pesananUser.attributes!.kuantitas} item',
                              style: AppTheme.softgreyTextStyle),
                        ],
                      ),
                    ),
                    Text(
                      '${AppMethods.currency(widget.pesananUser.attributes!.total.toString())}',
                      style: AppTheme.primaryTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      controller.pickMenu('Detail Permintaan', 1);
                      permintaanController
                          .setDataPermintaanAdmin(widget.pesananUser);
                    },
                    child: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 15,
                      child: Icon(Icons.remove_red_eye,
                          color: AppColors.whiteColor, size: 17),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () async {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        width: MediaQuery.of(context).size.width * 0.3,
                        confirmBtnText: 'Hapus',
                        confirmBtnColor: AppColors.dangerColor,
                        cancelBtnText: 'Batal',
                        showCancelBtn: true,
                        text: 'Kamu yakin ingin menghapus data permintaan ini?',
                        onConfirmBtnTap: () {
                          deletePermintaan(widget.pesananUser.id.toString());
                        },
                      ).then((value) {
                        context.go('/auth/admin');
                        controller.pickMenu('Permintaan Data Masuk', 1);
                        // context.go('/auth/admin');
                      });
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.dangerColor,
                      child: Icon(Icons.delete,
                          color: AppColors.whiteColor, size: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemPesananAdminMobileWidget extends StatefulWidget {
  final listPermintaanModelAdmin.PermintaanAdminData pesananUser;
  const ItemPesananAdminMobileWidget({
    super.key,
    required this.pesananUser,
  });

  @override
  State<ItemPesananAdminMobileWidget> createState() =>
      _ItemPesananAdminMobileWidgetState();
}

class _ItemPesananAdminMobileWidgetState
    extends State<ItemPesananAdminMobileWidget> {
  void deletePermintaan(String idPermintaan) async {
    final result =
        await PermintaanService.deletePermintaanByAdmin(idPermintaan);
    if (result == true) {
      // ignore: use_build_context_synchronously
      AppMethods.successToast(context, 'Data permintaan berhasil dihapus');
      setState(() {});
    } else {
      // ignore: use_build_context_synchronously
      AppMethods.dangerToast(context, 'Gagal menghapus data, coba lagi');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AdminController>();
    final permintaanController = context.watch<PermintaanController>();

    print('data widget ${widget.pesananUser.attributes}');
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${widget.pesananUser.attributes!.nomorPermintaan}',
                style: AppTheme.primaryTextStyle
                    .copyWith(fontWeight: AppTheme.bold, fontSize: 14),
              ),
              Text(
                widget.pesananUser.attributes!.status.toString(),
                style: AppTheme.blackTextStyle
                    .copyWith(fontWeight: AppTheme.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.pesananUser.attributes!.nama.toString(),
              style: AppTheme.blackTextStyle
                  .copyWith(fontSize: 18, fontWeight: AppTheme.medium),
            ),
            Text(
              'Dibuat pada ${AppMethods.date(widget.pesananUser.attributes!.createdAt.toString())}',
              style: AppTheme.blackTextStyle.copyWith(fontSize: 12),
            ),
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.pickMenu('Detail Permintaan', 1);
                  print(widget.pesananUser);
                  permintaanController
                      .setDataPermintaanAdmin(widget.pesananUser);
                  print('print ${permintaanController.permintaan}');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor,
                  ),
                  child: Text('Lihat Detail',
                      style: AppTheme.whiteTextStyle.copyWith(fontSize: 14)),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    width: MediaQuery.of(context).size.width * 0.3,
                    confirmBtnText: 'Hapus',
                    confirmBtnColor: AppColors.dangerColor,
                    cancelBtnText: 'Batal',
                    showCancelBtn: true,
                    text: 'Kamu yakin ingin menghapus data permintaan ini?',
                    onConfirmBtnTap: () {
                      deletePermintaan(widget.pesananUser.id.toString());
                    },
                  ).then((value) {
                    context.go('/auth/admin');
                    controller.pickMenu('Permintaan Data Masuk', 1);
                    // context.go('/auth/admin');
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.dangerColor,
                  ),
                  child: Text('Hapus',
                      style: AppTheme.whiteTextStyle.copyWith(fontSize: 14)),
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //       Text(
          //         widget.pesananUser.attributes!.nama.toString(),
          //         style: AppTheme.blackTextStyle
          //             .copyWith(fontSize: 18, fontWeight: AppTheme.medium),
          //       ),
          //       Text(
          //         'Dibuat pada ${AppMethods.date(widget.pesananUser.attributes!.createdAt.toString())}',
          //         style: AppTheme.blackTextStyle.copyWith(fontSize: 12),
          //       ),
          //     ]),
          //     const SizedBox(height: 5),
          //     Expanded(
          //       child: Column(
          //         children: [
          //           RichText(
          //             textAlign: TextAlign.center,
          //             text: TextSpan(
          //               text:
          //                   '${widget.pesananUser.attributes!.layanan == null ? '' : widget.pesananUser.attributes!.layanan!.attributes!.judul} ',
          //               style: AppTheme.primaryTextStyle.copyWith(
          //                 fontWeight: AppTheme.bold,
          //               ),
          //               children: [
          //                 TextSpan(
          //                     text:
          //                         'untuk ${widget.pesananUser.attributes!.kuantitas} item',
          //                     style: AppTheme.softgreyTextStyle),
          //               ],
          //             ),
          //           ),
          //           Text(
          //             '${AppMethods.currency(widget.pesananUser.attributes!.total.toString())}',
          //             style: AppTheme.primaryTextStyle.copyWith(
          //               fontWeight: AppTheme.bold,
          //               fontSize: 18,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 15),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             controller.pickMenu('Detail Permintaan', 1);
          //             print(widget.pesananUser);
          //             permintaanController
          //                 .setDataPermintaanAdmin(widget.pesananUser);
          //             print('print ${permintaanController.permintaan}');
          //           },
          //           child: const CircleAvatar(
          //             backgroundColor: AppColors.primaryColor,
          //             radius: 15,
          //             child: Icon(Icons.remove_red_eye,
          //                 color: AppColors.whiteColor, size: 17),
          //           ),
          //         ),
          //         const SizedBox(width: 10),
          //         InkWell(
          //           onTap: () async {
          //             CoolAlert.show(
          //               context: context,
          //               type: CoolAlertType.warning,
          //               width: MediaQuery.of(context).size.width * 0.3,
          //               confirmBtnText: 'Hapus',
          //               confirmBtnColor: AppColors.dangerColor,
          //               cancelBtnText: 'Batal',
          //               showCancelBtn: true,
          //               text: 'Kamu yakin ingin menghapus data permintaan ini?',
          //               onConfirmBtnTap: () {
          //                 deletePermintaan(widget.pesananUser.id.toString());
          //               },
          //             ).then((value) {
          //               context.go('/auth/admin');
          //               controller.pickMenu('Permintaan Data Masuk', 1);
          //               // context.go('/auth/admin');
          //             });
          //           },
          //           child: const CircleAvatar(
          //             radius: 15,
          //             backgroundColor: AppColors.dangerColor,
          //             child: Icon(Icons.delete,
          //                 color: AppColors.whiteColor, size: 17),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
