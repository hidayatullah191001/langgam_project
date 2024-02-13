part of '../pages.dart';

class DownloadSection extends StatelessWidget {
  const DownloadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openURLInNewTab(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    return FutureBuilder(
      future: PermintaanService.getAllDokumenPermintaanCustomer(),
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

          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: model.data!.length,
            itemBuilder: (context, index) {
              final data = model.data![index];
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.backgroundColor2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('# ${data.attributes!.nomorPermintaan}',
                        style: AppTheme.primaryTextStyle),
                    Text(
                      '${data.attributes!.nama}',
                      style: AppTheme.blackTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
                    ),
                    Text(
                      'Status : ${data.attributes!.status}',
                      style: AppTheme.greenTextStyle
                          .copyWith(fontWeight: AppTheme.medium),
                    ),
                    InkWell(
                      onTap: () {
                        openURLInNewTab(
                            '${Constant.host}${data.attributes!.dokumenPermintaan!.data!.attributes!.url}');
                      },
                      child: Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.file,
                            size: 20,
                            color: AppColors.softgreyColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            data.attributes!.dokumenPermintaan!.data!
                                .attributes!.name
                                .toString(),
                            style: AppTheme.primaryTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // TextButtonHovered(
                    //   text:
                    //       '${data.attributes!.dokumenPermintaan!.data!.attributes!.name}',
                    //   onTap: () {

                    //   },
                    //   styleHovered: AppTheme.blackTextStyle.copyWith(
                    //     fontWeight: AppTheme.bold,
                    //   ),
                    // ),
                  ],
                ),
              );
              // return ItemPesanan(pesananUser: model.data![index]);
            },
          );
        }
        return Container();
      },
    );
  }
}
