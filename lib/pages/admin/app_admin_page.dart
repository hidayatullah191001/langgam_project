part of '../pages.dart';

class AppAdminPage extends StatelessWidget {
  const AppAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AdminController>();
    List<String> menuAdmin = ['Dashboard', 'Permintaan Data Masuk', 'Tahapan Pelayanan'];
    return Scaffold(
      body: Row(
        children: [
          SideBarAnimated(
            onTap: (s) {
              controller.pickMenu(menuAdmin[s].toString(), s);
            },
            // sideBarColor: Colors.white,
            // animatedContainerColor: Colors.white,
            widthSwitch: 700,
            mainLogoImage: 'images/logo.png',
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
                iconSelected: CupertinoIcons.chart_bar_square_fill,
                iconUnselected: CupertinoIcons.chart_bar_square,
                text: menuAdmin[2].toString(),
              ),
              // SideBarItem(
              //   iconSelected: Icons.credit_card_rounded,
              //   text: 'Payouts',
              // ),
              // SideBarItem(
              //   iconSelected: Icons.settings,
              //   iconUnselected: Icons.settings_outlined,
              //   text: 'Settings',
              // ),
            ],
          ),
          buildConditionalWidget(controller.selectedMenu == 'Dashboard',
              const DashboardAdminSection()),
          buildConditionalWidget(controller.selectedMenu == 'Permintaan Data Masuk',
              const DashboardAdminSection()),
          buildConditionalWidget(controller.selectedMenu == 'Tahapan Pelayanan',
              const DashboardAdminSection()),

        ],
      ),
    );
  }

  Widget buildConditionalWidget(dynamic condition, Widget widget) {
    return condition
        ? Expanded(
            child: widget,
          )
        : Container();
  }
}
