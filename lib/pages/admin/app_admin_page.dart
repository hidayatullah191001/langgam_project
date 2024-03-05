part of '../pages.dart';

class AppAdminPage extends StatefulWidget {
  const AppAdminPage({Key? key}) : super(key: key);

  @override
  State<AppAdminPage> createState() => _AppAdminPageState();
}

class _AppAdminPageState extends State<AppAdminPage> {
  Map<String, dynamic> user = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  getDataUser() async {
    final Map<String, dynamic> data = await AppSession.getUserInformation();
    setState(() {
      user = data;
    });
  }

  List<String> menuAdmin = [
    'Dashboard',
    'Permintaan Data Masuk',
    'Rekap Permintaan',
    'Logbook',
    'Logout',
  ];

  static const List<Widget> _section = [
    DashboardAdminSection(),
    PelayananMasukSection(),
    RekapPermintaanSection(),
    LogbookSection(),
    DetailPermintaanSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return mobileView(context);
      } else {
        return webView(context);
      }
    });
  }

  Widget mobileView(BuildContext context) {
    final controller = context.watch<AdminController>();
    final selectedMenu = controller.selectedMenu;
    final authController = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Langgam Admin',
          style: AppTheme.whiteTextStyle.copyWith(
            fontWeight: AppTheme.bold,
            fontSize: 14,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.person_outlined,
                color: AppColors.softgreyColor,
                size: 14,
              ),
              const SizedBox(width: 10),
              Text(
                'Halo, ${user['username']}',
                style: AppTheme.whiteTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: selectedMenu == 'Detail Permintaan'
          ? DetailPermintaanSection()
          : _section[controller.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
            ),
            label: 'Permintaan Masuk',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_copy,
            ),
            label: 'Rekap Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notes_rounded,
            ),
            label: 'Logbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.arrow_left_circle,
              color: AppColors.dangerColor,
            ),
            label: 'Logout',
          ),
        ],
        currentIndex: controller.selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: controller.selectedIndex != 5
            ? AppColors.greyColor
            : AppColors.dangerColor,
        onTap: (int index) {
          if (index == 4) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.warning,
              width: MediaQuery.of(context).size.width * 0.3,
              confirmBtnText: 'Logout',
              confirmBtnColor: AppColors.dangerColor,
              cancelBtnText: 'Batal',
              confirmBtnTextStyle: AppTheme.whiteTextStyle,
              cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
              text: 'Kamu yakin ingin keluar dari aplikasi?',
              showCancelBtn: true,
              onConfirmBtnTap: () {
                authController.logout();
                context.replace('/auth');
                context.pop();
              },
              onCancelBtnTap: () {
                controller.pickMenu(menuAdmin[0].toString(), 0);
              },
            );
          } else {
            controller.pickMenu(menuAdmin[index], index);
          }
        },
      ),
    );
  }

  Widget webView(BuildContext context) {
    final controller = context.watch<AdminController>();
    final authController = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          SideBarAnimated(
            onTap: (s) {
              if (menuAdmin[s] == 'Logout') {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  width: MediaQuery.of(context).size.width * 0.3,
                  confirmBtnText: 'Logout',
                  confirmBtnColor: AppColors.dangerColor,
                  cancelBtnText: 'Batal',
                  confirmBtnTextStyle: AppTheme.whiteTextStyle,
                  cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
                  text: 'Kamu yakin ingin keluar dari aplikasi?',
                  showCancelBtn: true,
                  onConfirmBtnTap: () {
                    authController.logout();
                    context.replace('/auth');
                    context.pop();
                  },
                  onCancelBtnTap: () {
                    controller.pickMenu(menuAdmin[0].toString(), 0);
                    setState(() {
                      s = 0;
                    });
                  },
                );
              } else {
                controller.pickMenu(menuAdmin[s].toString(), s);
              }
            },
            sideBarColor: Colors.white,
            animatedContainerColor: AppColors.primaryColor,
            hoverColor: AppColors.backgroundColor2,
            widthSwitch: 700,
            mainLogoImage: 'images/logo.png',
            highlightColor: AppColors.primaryColor,
            textStyle: AppTheme.whiteTextStyle,
            selectedIconColor: AppColors.blackColor,
            sidebarItems: [
              SideBarItem(
                iconSelected: Icons.home_rounded,
                iconUnselected: Icons.home_outlined,
                text: menuAdmin[0].toString(),
              ),
              SideBarItem(
                iconSelected: Icons.account_balance_wallet,
                iconUnselected: Icons.account_balance_wallet_outlined,
                text: menuAdmin[1].toString(),
              ),
              SideBarItem(
                iconSelected: Icons.file_copy,
                iconUnselected: Icons.file_copy_outlined,
                text: menuAdmin[2].toString(),
              ),
              SideBarItem(
                iconSelected: Icons.notes_rounded,
                iconUnselected: Icons.notes_rounded,
                text: menuAdmin[3].toString(),
              ),
              SideBarItem(
                iconSelected: CupertinoIcons.arrow_left_circle,
                iconUnselected: CupertinoIcons.arrow_left_circle,
                text: menuAdmin[4].toString(),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  bool mobile = false;
                  if (constraints.maxWidth < 800) {
                    mobile = true;
                  } else {
                    mobile = false;
                  }
                  return Container(
                    margin: EdgeInsets.only(
                      right: mobile ? 10 : 40,
                      top: 25,
                      bottom: 30,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.person_outlined,
                          color: AppColors.softgreyColor,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Halo, ${user['username']}',
                          style: AppTheme.blackTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                buildConditionalWidget(controller.selectedMenu == 'Dashboard',
                    const DashboardAdminSection()),
                buildConditionalWidget(
                    controller.selectedMenu == 'Permintaan Data Masuk',
                    const PelayananMasukSection()),
                buildConditionalWidget(
                    controller.selectedMenu == 'Tahapan Pelayanan',
                    const DashboardAdminSection()),
                buildConditionalWidget(
                    controller.selectedMenu == 'Detail Permintaan',
                    const DetailPermintaanSection()),
                buildConditionalWidget(
                    controller.selectedMenu == 'Rekap Permintaan',
                    const RekapPermintaanSection()),
                buildConditionalWidget(controller.selectedMenu == 'Logbook',
                    const LogbookSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildConditionalWidget(dynamic condition, Widget widget) {
    return condition ? Expanded(child: widget) : Container();
  }
}
