part of '../pages.dart';

class DownloadSection extends StatefulWidget {
  const DownloadSection({Key? key}) : super(key: key);

  @override
  State<DownloadSection> createState() => _DownloadSectionState();
}

class _DownloadSectionState extends State<DownloadSection> {
  int selectedPageNumber = 1;
  int selectedPageSize = 10;

  List<int> _pageSize = [10, 20, 50, 100];

  void openURLInNewTab(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return mobileView();
      } else {
        return webView();
      }
    });
  }

  Widget webView() {
    return FutureBuilder(
      future: PermintaanService.getAllDokumenPermintaanCustomer(
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
                    'Kamu belum memiliki file unduhan',
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.data!.length,
                itemBuilder: (context, index) {
                  final data = model.data![index];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
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
                      ],
                    ),
                  );
                },
              ),
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

  Widget mobileView() {
    return FutureBuilder(
      future: PermintaanService.getAllDokumenPermintaanCustomer(
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
                    'Kamu belum memiliki file unduhan',
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
                    width: MediaQuery.of(context).size.width * 0.1,
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
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.data!.length,
                itemBuilder: (context, index) {
                  final data = model.data![index];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 10),
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
                            Text('# ${data.attributes!.nomorPermintaan}',
                                style: AppTheme.primaryTextStyle),
                            Text(
                              '${data.attributes!.nama}',
                              style: AppTheme.blackTextStyle.copyWith(
                                fontWeight: AppTheme.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                            ])
                      ],
                    ),
                  );
                },
              ),
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
