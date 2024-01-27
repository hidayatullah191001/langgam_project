part of '../pages.dart';

class AppAdminPage extends StatelessWidget {
  const AppAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBarAnimated2(
            onTap: (s) {},
            // sideBarColor: Colors.white,
            // animatedContainerColor: Colors.white,
            widthSwitch: 700,
            mainLogoImage: 'assets/logo.png',
            sidebarItems: [
              SideBarItem(
                iconSelected: Icons.home_rounded,
                iconUnselected: Icons.home_outlined,
                text: 'Home',
              ),
              SideBarItem(
                iconSelected: Icons.account_balance_wallet,
                iconUnselected: Icons.account_balance_wallet_outlined,
                text: 'Insights',
              ),
              SideBarItem(
                iconSelected: CupertinoIcons.chart_bar_square_fill,
                iconUnselected: CupertinoIcons.chart_bar_square,
                text: 'Feature',
              ),
              SideBarItem(
                iconSelected: Icons.credit_card_rounded,
                text: 'Payouts',
              ),
              SideBarItem(
                iconSelected: Icons.settings,
                iconUnselected: Icons.settings_outlined,
                text: 'Settings',
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 20),
            ),
          ),
        ],
      ),
    );
  }
}
