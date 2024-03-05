part of '../pages.dart';

class DashboardSectionMobile extends StatelessWidget {
  const DashboardSectionMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    final authController = context.watch<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            fastButtonDasborMobile(context,
                title: 'Pesanan',
                icon: Icons.file_open_outlined,
                first: true, onTap: () {
              controller.pickMenu('Pesanan', 1);
            }),
            fastButtonDasborMobile(context,
                title: 'Unduhan',
                icon: Icons.file_download_outlined,
                last: true, onTap: () {
              controller.pickMenu('Unduhan', 3);
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            fastButtonDasborMobile(context,
                title: 'Detail Akun', icon: Icons.person_outlined, onTap: () {
              controller.pickMenu('Detail Akun', 5);
            }),
            // fastButtonDasborMobile(
            //   context,
            //   title: 'Logout',
            //   icon: Icons.logout,
            //   first: true,
            //   last: true,
            //   typeLogout: true,
            //   onTap: () {
            //     controller.pickMenu(menuUser[4], 4);
            //     if (menuUser[4] == 'Logout') {
            //       CoolAlert.show(
            //         context: context,
            //         type: CoolAlertType.warning,
            //         width: MediaQuery.of(context).size.width * 0.3,
            //         confirmBtnText: 'Logout',
            //         confirmBtnColor: AppColors.dangerColor,
            //         cancelBtnText: 'Batal',
            //         confirmBtnTextStyle: AppTheme.whiteTextStyle,
            //         cancelBtnTextStyle: AppTheme.darkGreyTextStyle,
            //         text: 'Kamu yakin ingin keluar dari aplikasi?',
            //         showCancelBtn: true,
            //         onConfirmBtnTap: () {
            //           authController.logout();
            //           context.replace('/');
            //           context.pop();
            //         },
            //       ).then((value) => context.pop());
            //     }
            //   },
            // ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     fastButtonDasborMobile(
        //       context,
        //       title: 'Logout',
        //       icon: Icons.logout,
        //       first: true,
        //       last: true,
        //       typeLogout: true,
        //       onTap: () {
        //         Navigator.pushReplacementNamed(context, '/register');
        //       },
        //     ),
        //   ],
        // )
      ],
    );
  }

  Widget fastButtonDasborMobile(
    BuildContext context, {
    bool first = false,
    bool last = false,
    bool typeLogout = false,
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(
            left: first ? 0 : 5,
            right: last ? 0 : 5,
            bottom: 20,
            top: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: typeLogout ? AppColors.dangerColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.softgreyColor.withOpacity(0.2),
              width: 3,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color:
                      typeLogout ? AppColors.whiteColor : AppColors.greyColor,
                  size: 50),
              const SizedBox(height: 5),
              Text(
                title,
                style: typeLogout
                    ? AppTheme.whiteTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 14,
                      )
                    : AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                        fontSize: 14,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
