part of 'widgets.dart';

class BannerTop extends StatelessWidget {
  const BannerTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavbarController>();

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
              children: const [
                FaIcon(
                  FontAwesomeIcons.facebookF,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                FaIcon(
                  FontAwesomeIcons.instagram,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                FaIcon(
                  FontAwesomeIcons.youtube,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              'BMKG Langgam Buka Jam : 08.00 - 21.00 Senin - Sabtu',
              style: AppTheme.whiteTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                  controller.pickDrawer('Login');
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
                      'LOGIN / DAFTAR',
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

class BannerTopAuth extends StatelessWidget {
  const BannerTopAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: const [
                FaIcon(
                  FontAwesomeIcons.facebookF,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                FaIcon(
                  FontAwesomeIcons.instagram,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
                SizedBox(
                  width: 12,
                ),
                FaIcon(
                  FontAwesomeIcons.youtube,
                  color: AppColors.whiteColor,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              'BMKG Langgam Buka Jam : 08.00 - 21.00 Senin - Sabtu',
              style: AppTheme.whiteTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
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
                      'HALO, HIDAYATULLAH',
                      style: AppTheme.whiteTextStyle.copyWith(
                        fontSize: 12,
                        letterSpacing: 1.2,
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
