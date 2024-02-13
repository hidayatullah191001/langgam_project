part of '../pages.dart';

class DashboardAdminSection extends StatefulWidget {
  const DashboardAdminSection({Key? key}) : super(key: key);

  @override
  State<DashboardAdminSection> createState() => _DashboardAdminSectionState();
}

class _DashboardAdminSectionState extends State<DashboardAdminSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PermintaanController>().getCountPermintaanByStatus();
  }

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
      child: Consumer<PermintaanController>(
        builder: (context, PermintaanController permintaanController, child) {
          if (permintaanController.dataState == DataState.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (permintaanController.dataState == DataState.error) {
            return Center(child: Text('Something went wrong'));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return MobileView(permintaanController);
              } else {
                return WebView(permintaanController);
              }
            },
          );
        },
      ),
    );
  }

  Widget MobileView(PermintaanController permintaanController) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Text(
          'Selamat Datang di halaman dashboard Admin Layanan Terpadu BMKG. Pantau dan Kelola semua permintaan customer',
          style: AppTheme.darkGreyTextStyle.copyWith(
            fontWeight: AppTheme.bold,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        CountStatusWidget(
          backgroundColor: AppColors.dangerColor,
          icon: Icons.file_copy,
          count: permintaanController.countMenungguPersetujuan.toString(),
          status: 'Menunggu Pembayaran',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.warningColor,
          icon: Icons.list_alt_rounded,
          count: permintaanController.countVerifikasiPersyaratan.toString(),
          status: 'Verifikasi Persyaratan',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.infoColor,
          icon: Icons.attach_money_rounded,
          count: permintaanController.countMenungguPembayaran.toString(),
          status: 'Menunggu Pembayaran',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.primaryColor,
          icon: Icons.inventory_outlined,
          count: permintaanController.countVerifikasiPembayaran.toString(),
          status: 'Verifikasi Pembayaran',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.softgreyColor,
          icon: Icons.list_alt_rounded,
          count: permintaanController.countSedangDiproses.toString(),
          status: 'Sedang Diproses',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.successColor,
          icon: Icons.check_circle_outline_rounded,
          count: permintaanController.countSelesai.toString(),
          status: 'Selesai',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.warningColor,
          icon: Icons.woo_commerce_rounded,
          count: permintaanController.countKomersial.toString(),
          status: 'Komersial',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.dangerColor,
          icon: Icons.attach_money_sharp,
          fontSize: 20,
          count: AppMethods.currency(
              permintaanController.totalPendapatanKotor.toString()),
          status: 'Total Pendapatan Kotor',
        ),
        const SizedBox(height: 20),
        CountStatusWidget(
          backgroundColor: AppColors.successColor,
          icon: Icons.money,
          fontSize: 20,
          count: AppMethods.currency(
              permintaanController.totalPendapatanSelesai.toString()),
          status: 'Total Pendapatan Selesai',
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.backgroundColor3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Permintaan Terbaru',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: PermintaanService.getAllNewPermintaan(),
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
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ItemPesananAdminMobileWidget(
                          pesananUser: model.data![index],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget WebView(PermintaanController permintaanController) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Selamat Datang di halaman dashboard Admin Layanan Terpadu BMKG. Pantau dan Kelola semua permintaan customer',
              style: AppTheme.darkGreyTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountStatusWidget(
                  backgroundColor: AppColors.dangerColor,
                  icon: Icons.file_copy,
                  count:
                      permintaanController.countMenungguPersetujuan.toString(),
                  status: 'Menunggu Pembayaran',
                ),
                const SizedBox(width: 20),
                CountStatusWidget(
                  backgroundColor: AppColors.warningColor,
                  icon: Icons.list_alt_rounded,
                  count: permintaanController.countVerifikasiPersyaratan
                      .toString(),
                  status: 'Verifikasi Persyaratan',
                ),
                const SizedBox(width: 20),
                CountStatusWidget(
                  backgroundColor: AppColors.infoColor,
                  icon: Icons.attach_money_rounded,
                  count:
                      permintaanController.countMenungguPembayaran.toString(),
                  status: 'Menunggu Pembayaran',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountStatusWidget(
                  backgroundColor: AppColors.primaryColor,
                  icon: Icons.inventory_outlined,
                  count:
                      permintaanController.countVerifikasiPembayaran.toString(),
                  status: 'Verifikasi Pembayaran',
                ),
                const SizedBox(width: 20),
                CountStatusWidget(
                  backgroundColor: AppColors.softgreyColor,
                  icon: Icons.list_alt_rounded,
                  count: permintaanController.countSedangDiproses.toString(),
                  status: 'Sedang Diproses',
                ),
                const SizedBox(width: 20),
                CountStatusWidget(
                  backgroundColor: AppColors.successColor,
                  icon: Icons.check_circle_outline_rounded,
                  count: permintaanController.countSelesai.toString(),
                  status: 'Selesai',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountStatusWidget(
                  backgroundColor: AppColors.warningColor,
                  icon: Icons.woo_commerce_rounded,
                  count: permintaanController.countKomersial.toString(),
                  status: 'Komersial',
                ),
                const SizedBox(width: 20),
                CountStatusWidget(
                  backgroundColor: AppColors.dangerColor,
                  icon: Icons.attach_money_sharp,
                  fontSize: 20,
                  count: AppMethods.currency(
                      permintaanController.totalPendapatanKotor.toString()),
                  status: 'Total Pendapatan Kotor',
                ),
                const SizedBox(width: 20),
                CountStatusWidget(
                  backgroundColor: AppColors.successColor,
                  icon: Icons.money,
                  fontSize: 20,
                  count: AppMethods.currency(
                      permintaanController.totalPendapatanSelesai.toString()),
                  status: 'Total Pendapatan Selesai',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.backgroundColor3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Permintaan Terbaru',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: PermintaanService.getAllNewPermintaan(),
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
                        listPermintaanModelAdmin.ListPermintaanModelAdmin
                            model = snapshot.data!;

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
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ItemPesananAdminWidget(
                              pesananUser: model.data![index],
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountStatusWidget extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String count;
  final String status;
  double? fontSize;
  CountStatusWidget({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.count,
    required this.status,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: AppColors.whiteColor,
              size: 40,
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    count,
                    style: AppTheme.whiteTextStyle.copyWith(
                      fontSize: fontSize,
                      fontWeight: AppTheme.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    status,
                    style: AppTheme.whiteTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
