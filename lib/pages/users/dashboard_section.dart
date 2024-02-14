part of '../pages.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    final authController = context.watch<AuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Halo, ',
            style: AppTheme.greyTextStyle,
            children: <TextSpan>[
              TextSpan(
                text: 'hidayatullahd745',
                style: AppTheme.greyTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
              TextSpan(
                text: ' (bukan ',
                style: AppTheme.greyTextStyle,
              ),
              TextSpan(
                text: 'hidayatullahd745? ',
                style: AppTheme.greyTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
              TextSpan(
                text: 'Keluar',
                style: AppTheme.primaryTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
              TextSpan(
                text: ')',
                style: AppTheme.greyTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Dari dasbor akun anda, Anda dapat melihat ',
            style: AppTheme.greyTextStyle,
            children: <TextSpan>[
              TextSpan(text: 'pesanan baru', style: AppTheme.greyTextStyle),
              TextSpan(
                text: ', mengelola ',
                style: AppTheme.greyTextStyle,
              ),
              TextSpan(
                text: 'alamat pengiriman dan penagihan',
                style: AppTheme.primaryTextStyle,
              ),
              TextSpan(
                text: ', dan ',
                style: AppTheme.greyTextStyle,
              ),
              TextSpan(
                text: 'edit kata sandi anda dan detail akun Anda',
                style: AppTheme.primaryTextStyle,
              ),
              TextSpan(
                text: '.',
                style: AppTheme.greyTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FastButtonDasbor(context,
                title: 'Pesanan',
                icon: Icons.file_open_outlined,
                first: true, onTap: () {
              controller.pickMenu('Pesanan', 1);
            }),
            // FastButtonDasbor(context,
            //     title: 'Messages', icon: Icons.message_sharp, onTap: () {
            //   controller.pickMenu('Messages', 2);
            // }),
            FastButtonDasbor(context,
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
            // FastButtonDasbor(context,
            //     title: 'Alamat',
            //     icon: Icons.location_on_outlined,
            //     first: true, onTap: () {
            //   controller.pickMenu('Alamat', 4);
            // }),
            FastButtonDasbor(context,
                title: 'Detail Akun', icon: Icons.person_outlined, onTap: () {
              controller.pickMenu('Detail Akun', 5);
            }),
            // FastButtonDasbor(context,
            //     title: 'Attchments',
            //     icon: Icons.file_present_outlined,
            //     last: true, onTap: () {
            //   controller.pickMenu('Attachments', 6);
            // }),
            FastButtonDasbor(
              context,
              title: 'Logout',
              icon: Icons.logout,
              first: true,
              last: true,
              typeLogout: true,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     FastButtonDasbor(
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

  Widget FastButtonDasbor(
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
            left: first ? 0 : 10,
            right: last ? 0 : 10,
            bottom: 20,
            top: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 30,
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
                      )
                    : AppTheme.greyTextStyle.copyWith(
                        fontWeight: AppTheme.bold,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
