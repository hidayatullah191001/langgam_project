part of '../pages.dart';

class LoginAdminPage extends StatelessWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
        ),
        child: Column(
          children: [
            Image.asset(
              'images/logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            Text(
              'Langgam | Pelayanan Terpadu',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
              ),
            ),
            const SizedBox(height: 30),
            CustomFormUser(
              title: 'Username',
              isMandatory: true,
            ),
            const SizedBox(height: 15),
            CustomFormUser(
              title: 'Password',
              isMandatory: true,
              isObscure: true,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onTap: () {},
              titleButton: 'Login',
            ),
            Text(
              'Balai Besar Meteorologi, Klimatologi dan Geofisika Wilayah II Ciputat',
              style: AppTheme.greyTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
