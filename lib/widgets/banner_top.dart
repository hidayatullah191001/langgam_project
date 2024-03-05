part of 'widgets.dart';

class BannerTop extends StatefulWidget {
  const BannerTop({Key? key}) : super(key: key);

  @override
  State<BannerTop> createState() => _BannerTopState();
}

class _BannerTopState extends State<BannerTop> {
  Map<String, dynamic> user = {};

  @override
  void initState() {
    super.initState();
    getDataUser();
    context.read<SettingController>().getSettingWeb();
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();
    final settingController = context.watch<SettingController>();
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Row(
          children: [
            Row(
              children: [
                Consumer(
                    builder: (context, SettingController controller, widget) {
                  if (controller.dataState == DataState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: settingController
                        .setting.data!.attributes!.sosmed!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      List icon = [
                        FontAwesomeIcons.facebookF,
                        FontAwesomeIcons.whatsapp,
                        FontAwesomeIcons.youtube,
                      ];
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              AppMethods.openLinkNewTab(settingController
                                  .setting.data!.attributes!.sosmed![index].url
                                  .toString());
                            },
                            child: FaIcon(
                              icon[index],
                              color: AppColors.whiteColor,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
            const Spacer(),
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  if (user['username'] == null &&
                      user['email'] == null &&
                      user['token'] == null) {
                    Scaffold.of(context).openEndDrawer();
                    controller.pickDrawer('Login');
                  } else {
                    context.go('/my-account');
                  }
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xff2850b8),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        color: AppColors.whiteColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      user['username'] == null &&
                              user['email'] == null &&
                              user['password'] == null
                          ? 'LOGIN / DAFTAR'
                          : 'HALO, ${user['username']}'.toUpperCase(),
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class BannerTopMobile extends StatefulWidget {
  const BannerTopMobile({Key? key}) : super(key: key);

  @override
  State<BannerTopMobile> createState() => _BannerTopMobileState();
}

class _BannerTopMobileState extends State<BannerTopMobile> {
  Map<String, dynamic> user = {};

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    getDataUser();
    context.read<SettingController>().getSettingWeb();
    super.initState();
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();
    final settingController = context.watch<SettingController>();

    return Row(
      children: [
        Row(
          children: [
            Consumer(builder: (context, SettingController controller, widget) {
              if (controller.dataState == DataState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: settingController
                        .setting.data!.attributes!.sosmed!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      List icon = [
                        FontAwesomeIcons.facebookF,
                        FontAwesomeIcons.whatsapp,
                        FontAwesomeIcons.youtube,
                      ];
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              AppMethods.openLinkNewTab(settingController
                                  .setting.data!.attributes!.sosmed![index].url
                                  .toString());
                            },
                            child: FaIcon(
                              icon[index],
                              color: AppColors.whiteColor,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            if (user['username'] == null &&
                user['email'] == null &&
                user['token'] == null) {
              context.go('/register');
            } else {
              context.go('/my-account');
            }
          },
          child: Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xff2850b8),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                user['username'] == null &&
                        user['email'] == null &&
                        user['password'] == null
                    ? 'LOGIN / DAFTAR'
                    : 'HALO, ${user['username']}'.toUpperCase(),
                style: AppTheme.whiteTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
