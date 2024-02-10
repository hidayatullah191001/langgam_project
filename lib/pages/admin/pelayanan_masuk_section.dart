part of '../pages.dart';

class PelayananMasukSection extends StatefulWidget {
  const PelayananMasukSection({Key? key}) : super(key: key);

  @override
  State<PelayananMasukSection> createState() => _PelayananMasukSectionState();
}

class _PelayananMasukSectionState extends State<PelayananMasukSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final permintaanController = context.watch<PermintaanController>();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: FutureBuilder<listPermintaanModelAdmin.ListPermintaanModelAdmin>(
        future: PermintaanService.getAllPermintaan(),
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
            listPermintaanModelAdmin.ListPermintaanModelAdmin model = snapshot
                .data as listPermintaanModelAdmin.ListPermintaanModelAdmin;

            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: model.data!.length,
              itemBuilder: (context, index) {
                // return ItemPesanan(pesananUser: model.data![index]);
                return ItemPesananAdminWidget(pesananUser: model.data![index]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ItemPesananAdminWidget extends StatefulWidget {
  final listPermintaanModelAdmin.Data pesananUser;
  const ItemPesananAdminWidget({
    super.key,
    required this.pesananUser,
  });

  @override
  State<ItemPesananAdminWidget> createState() => _ItemPesananAdminWidgetState();
}

class _ItemPesananAdminWidgetState extends State<ItemPesananAdminWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AdminController>();
    final permintaanController = context.watch<PermintaanController>();
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
              Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          '${widget.pesananUser.attributes!.layanan!.attributes!.judul} ',
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
                      final result =
                          await PermintaanService.deletePermintaanByAdmin(
                              widget.pesananUser.id.toString());
                      if (result == true) {
                        // ignore: use_build_context_synchronously
                        CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                width: MediaQuery.of(context).size.width * 0.3,
                                text: "Data permintaan berhasil dihapus!")
                            .then((value) {
                          Navigator.pushReplacementNamed(context, '/admin')
                              .then((value) => controller.pickMenu(
                                  'Permintaan Data Masuk', 1));
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
