part of '../pages.dart';

class LoginAdminPage extends StatelessWidget {
  const LoginAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final controller = context.watch<AuthController>();
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return mobileView(
            context, emailController, passwordController, controller);
      } else {
        return webView(
            context, emailController, passwordController, controller);
      }
    });
  }

  Widget webView(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController, AuthController controller) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(100),
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.replace('/');
                },
                child: Column(children: [
                  Image.asset(
                    'images/logo.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Langgam | Pelayanan Terpadu',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 30),
              CustomFormUser(
                controller: emailController,
                title: 'Email',
                isMandatory: true,
              ),
              const SizedBox(height: 15),
              CustomFormUser(
                controller: passwordController,
                title: 'Password',
                isMandatory: true,
                isObscure: true,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onTap: () async {
                  if (!EmailValidator.validate(emailController.text)) {
                    CoolAlert.show(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.3,
                      type: CoolAlertType.error,
                      text: 'Email yang kamu masukkan tidak valid',
                    );
                  } else if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    CoolAlert.show(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.3,
                      type: CoolAlertType.error,
                      text: 'Email dan password tidak boleh kosong',
                    );
                  } else {
                    final model = SignInFormModel(
                      identifier: emailController.text,
                      password: passwordController.text,
                    );
                    final result = await controller.loginAdmin(model);
                    if (result['success'] == true) {
                      context.go('/auth/admin');
                    } else {
                      AppMethods.dangerToast(context, result['message']);
                    }
                  }
                },
                titleButton: 'Login',
              ),
              const SizedBox(height: 10),
              Text(
                'Balai Besar Meteorologi, Klimatologi dan Geofisika Wilayah II Ciputat',
                style: AppTheme.greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mobileView(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController, AuthController controller) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          padding: const EdgeInsets.all(50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.replace('/');
                },
                child: Column(children: [
                  Image.asset(
                    'images/logo.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Langgam | Pelayanan Terpadu',
                    style: AppTheme.blackTextStyle.copyWith(
                      fontWeight: AppTheme.bold,
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 30),
              CustomFormUser(
                controller: emailController,
                title: 'Email',
                isMandatory: true,
              ),
              const SizedBox(height: 15),
              CustomFormUser(
                controller: passwordController,
                title: 'Password',
                isMandatory: true,
                isObscure: true,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onTap: () async {
                  if (!EmailValidator.validate(emailController.text)) {
                    AppMethods.dangerToast(
                        context, 'Email yang kamu masukkan tidak valid');
                  } else if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    AppMethods.dangerToast(
                        context, 'Email dan password tidak boleh kosong');
                  } else {
                    final model = SignInFormModel(
                      identifier: emailController.text,
                      password: passwordController.text,
                    );
                    final result = await controller.loginAdmin(model);
                    if (result['success'] == true) {
                      context.go('/auth/admin');
                    } else {
                      AppMethods.dangerToast(context, result['message']);
                    }
                  }
                },
                titleButton: 'Login',
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Balai Besar Meteorologi, Klimatologi dan Geofisika Wilayah II Ciputat',
                  style: AppTheme.greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
