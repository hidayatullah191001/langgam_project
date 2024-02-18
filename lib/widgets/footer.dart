part of 'widgets.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  void initState() {
    context.read<SettingController>().getSettingWeb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingController = context.watch<SettingController>();
    final setting = settingController.setting.data?.attributes!;
    return Container(
      width: double.infinity,
      color: AppColors.footerprimaryColor,
      child: Consumer(builder: (context, SettingController controller, widget) {
        if (controller.dataState == DataState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 150.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/logo.png',
                          width: 100,
                        ),
                        const SizedBox(height: 35),
                        Text(
                          'LANGGAM - BMKG Wilayah II',
                          style: AppTheme.whiteTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.whiteColor,
                              size: 15,
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 300,
                              child: Text(
                                setting!.footerAlamat.toString(),
                                style: AppTheme.whiteTextStyle.copyWith(
                                  fontSize: 14,
                                  height: 2,
                                ),
                                maxLines: 5,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.phone_android,
                              color: AppColors.greyColor,
                              size: 15,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              setting.footerTelepon.toString(),
                              style: AppTheme.whiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.email,
                              color: AppColors.greyColor,
                              size: 15,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              setting.footerEmail.toString(),
                              style: AppTheme.whiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'POST TERBARU',
                            style: AppTheme.whiteTextStyle.copyWith(
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FutureBuilder(
                            future: BeritaService.getAllBerita(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: Text('Data Not Found'));
                              }

                              if (snapshot.hasData) {
                                List data = snapshot.data!.data as List;
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length > 2 ? 2 : data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final BeritaData berita = data[index];
                                    return InkWell(
                                      onTap: () {
                                        context.go(
                                            '/berita/${berita.attributes!.slug}');
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${Constant.host}${berita.attributes!.gambar!.data!.attributes!.url.toString()}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      berita.attributes!.judul
                                                          .toString(),
                                                      style: AppTheme
                                                          .whiteTextStyle
                                                          .copyWith(
                                                        fontWeight:
                                                            AppTheme.medium,
                                                      ),
                                                      maxLines: 5,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      'Dibuat pada ${AppMethods.date(berita.attributes!.createdAt!)}',
                                                      style: AppTheme
                                                          .softgreyTextStyle
                                                          .copyWith(
                                                              fontSize: 14),
                                                      maxLines: 5,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Container(
                                              width: 300,
                                              height: 1,
                                              color: const Color(0xff355796),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
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
                    const SizedBox(width: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BANTUAN',
                          style: AppTheme.whiteTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                          future: BantuanService.getAllBantuan(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              List<BantuanData> data = snapshot.data!.data!;
                              return SizedBox(
                                width: 200,
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final BantuanAttributes bantuan =
                                        data[index].attributes!;
                                    return TextButtonHovered(
                                      onTap: () {
                                        context.go('/bantuan/${bantuan.slug}');
                                      },
                                      text: bantuan.judul.toString(),
                                    );
                                  },
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xff355796),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 150.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        setting.footerCredit.toString(),
                        style: AppTheme.softgreyTextStyle.copyWith(
                          fontWeight: AppTheme.medium,
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/payments.png',
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class FooterMobile extends StatefulWidget {
  const FooterMobile({Key? key}) : super(key: key);

  @override
  State<FooterMobile> createState() => _FooterMobileState();
}

class _FooterMobileState extends State<FooterMobile> {
  @override
  void initState() {
    context.read<SettingController>().getSettingWeb();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingController = context.watch<SettingController>();
    final setting = settingController.setting.data!.attributes!;
    return Container(
      width: double.infinity,
      color: AppColors.footerprimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Consumer(builder: (context, SettingController controller, widget) {
        if (controller.dataState == DataState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'images/logo.png',
                            width: 100,
                          ),
                          const SizedBox(height: 35),
                          Text(
                            'LANGGAM - BMKG Wilayah II',
                            style: AppTheme.whiteTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: AppColors.whiteColor,
                                size: 15,
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  setting.footerAlamat.toString(),
                                  style: AppTheme.whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    height: 2,
                                  ),
                                  maxLines: 5,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.phone_android,
                                color: AppColors.greyColor,
                                size: 15,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                setting.footerTelepon.toString(),
                                style: AppTheme.whiteTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.email,
                                color: AppColors.greyColor,
                                size: 15,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                setting.footerEmail.toString(),
                                style: AppTheme.whiteTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BANTUAN',
                          style: AppTheme.whiteTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                          future: BantuanService.getAllBantuan(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              List<BantuanData> data = snapshot.data!.data!;

                              return SizedBox(
                                width: 200,
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final BantuanAttributes bantuan =
                                        data[index].attributes!;
                                    return TextButtonHovered(
                                      onTap: () {
                                        context.go('/bantuan/${bantuan.slug}');
                                      },
                                      text: bantuan.judul.toString(),
                                    );
                                  },
                                ),
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
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xff355796),
              ),
              const SizedBox(height: 15),
              Text(
                setting.footerCredit.toString(),
                style: AppTheme.softgreyTextStyle.copyWith(
                  fontWeight: AppTheme.medium,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'images/payments.png',
              ),
            ],
          );
        }
      }),
    );
  }
}
