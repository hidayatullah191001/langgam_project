part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String stateLogin = 'MASUK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 1200) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('lottie/maintenance.json'),
                      Text(
                        'Saat ini hanya tersedia untuk Website. Gunakan laptop untuk membuka',
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const BannerTop(),
                  ]),
                ),
                const SliverAppBar(
                  pinned: true,
                  floating: false,
                  collapsedHeight: 101.0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Navbar(),
                  actions: [SizedBox()],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      HeroSection(
                        heroTitle: 'AKUN SAYA',
                        heroPosition: 'RUMAH  ',
                      ),
                      ContentSection(context),
                      const Footer(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget ContentSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stateLogin == 'MASUK'
                ? LoginForm(
                    contextPage: context,
                  )
                : RegisterForm(),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 0.3,
              height: stateLogin == 'MASUK' ? 400 : 250,
              child: Container(
                width: 0.3,
                height: double.infinity,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'REGISTER',
                    style: AppTheme.blackTextStyle
                        .copyWith(fontWeight: AppTheme.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Registering for this site allows you to access your order status and history. Just fill in the fields below, and we\'ll get a new account set up for you in no time. We will only ask you for information necessary to make the purchase process faster and easier.',
                    style: AppTheme.greyTextStyle.copyWith(
                      height: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    onTap: () {
                      if (stateLogin == 'MASUK') {
                        setState(() {
                          stateLogin = 'DAFTAR';
                        });
                      } else if (stateLogin == 'DAFTAR') {
                        setState(() {
                          stateLogin = 'MASUK';
                        });
                      }
                    },
                    titleButton: stateLogin == 'MASUK' ? 'DAFTAR' : 'MASUK',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final BuildContext contextPage;
  LoginForm({
    super.key,
    required this.contextPage,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MASUK',
            style: AppTheme.blackTextStyle
                .copyWith(fontWeight: AppTheme.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormUser(
            controller: emailController,
            title: 'Nama pengguna atau alamat email ',
            isMandatory: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormUser(
            controller: passwordController,
            title: 'Password',
            isObscure: true,
            isMandatory: true,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () async {
                if (!EmailValidator.validate(emailController.text)) {
                  AppMethods.dangerFlushbar(context, 'Email yang kamu masukkan tidak valid');

                  // CoolAlert.show(
                  //   context: context,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   type: CoolAlertType.error,
                  //   text: 'Email yang kamu masukkan tidak valid',
                  // );
                } else if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  AppMethods.dangerFlushbar(context, 'Email dan password tidak boleh kosong');
                  
                  // CoolAlert.show(
                  //   context: context,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   type: CoolAlertType.error,
                  //   text: 'Email dan password tidak boleh kosong',
                  // );
                } else {
                  final model = SignInFormModel(
                    identifier: emailController.text,
                    password: passwordController.text,
                  );
                  final result = await controller.loginUser(model);

                  if (result['success'] == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  } else {
                  AppMethods.dangerFlushbar(context, result['message']);
                    
                  }
                }
              },
              titleButton: 'MASUK',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  thickness: 0.3,
                  height: 0.3,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'ATAU LOGIN DENGAN',
                style: AppTheme.blackTextStyle.copyWith(
                  fontWeight: AppTheme.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Divider(
                  color: AppColors.blackColor,
                  thickness: 0.3,
                  height: 0.3,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SizedBox(
              width: double.infinity,
              child: Material(
                color: const Color(0xff4285f4),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {}, // Button Login Dengan GOOGLE
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 13,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(7),
                            image: const DecorationImage(
                              image: AssetImage('images/google-icon.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'GOOGLE',
                              style: AppTheme.whiteTextStyle.copyWith(
                                fontWeight: AppTheme.medium,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DAFTAR',
            style: AppTheme.blackTextStyle
                .copyWith(fontWeight: AppTheme.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                child: CustomFormUser(
                  controller: firstNameController,
                  title: 'First Name ',
                  isMandatory: true,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomFormUser(
                  controller: lastNameController,
                  title: 'Last Name ',
                  isMandatory: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomFormUser(
            controller: usernameController,
            title: 'Username ',
            isMandatory: true,
          ),
          const SizedBox(height: 10),
          CustomFormUser(
            controller: emailController,
            title: 'Email ',
            isMandatory: true,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                child: CustomFormUser(
                  controller: passwordController,
                  title: 'Password ',
                  isMandatory: true,
                  isObscure: true,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: CustomFormUser(
                  controller: repeatPasswordController,
                  title: 'Repeat Password ',
                  isMandatory: true,
                  isObscure: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Tautan untuk mengatur kata sandi baru akan dikirim ke alamat e-mail Anda.',
            style: AppTheme.greyTextStyle.copyWith(height: 1.5),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () async {
                if (!EmailValidator.validate(emailController.text)) {
                  AppMethods.dangerFlushbar(context, 'Email yang kamu masukkan tidak valid');
                  // CoolAlert.show(
                  //   context: context,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   type: CoolAlertType.error,
                  //   text: 'Email yang kamu masukkan tidak valid',
                  // );
                } else if (firstNameController.text.isEmpty ||
                    lastNameController.text.isEmpty ||
                    usernameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  AppMethods.dangerFlushbar(context, 'Field mandatory harus diisi');

                  // CoolAlert.show(
                  //   context: context,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   type: CoolAlertType.error,
                  //   text: 'Field mandatory harus diisi',
                  // );
                } else if (passwordController.text.length < 8) {
                  // CoolAlert.show(
                  //   context: context,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   type: CoolAlertType.error,
                  //   text: 'Password min 8 Char',
                  //   onConfirmBtnTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // );
                  AppMethods.dangerFlushbar(context, 'Password min 8 Char');

                } else if (passwordController.text !=
                    repeatPasswordController.text) {
                  // CoolAlert.show(
                  //   context: context,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   type: CoolAlertType.error,
                  //   text: 'Password tidak sama, coba lagi',
                  //   onConfirmBtnTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // );
                  AppMethods.dangerFlushbar(context, 'Password tidak sama, coba lagi!');

                } else {
                  final model = SignUpFormModel(
                    blocked: "false",
                    email: emailController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    password: passwordController.text,
                    username: usernameController.text,
                  );
                  final result = await controller.registerUser(model);

                  if (result['success'] == true) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  } else {
                    // ignore: use_build_context_synchronously
                    // CoolAlert.show(
                    //   context: context,
                    //   width: MediaQuery.of(context).size.width * 0.3,
                    //   type: CoolAlertType.error,
                    //   text: 'Something went wrong, please try again',
                    //   onConfirmBtnTap: () {
                    //     Navigator.pop(context);
                    //   },
                    // );
                  AppMethods.dangerFlushbar(context, result['message']);

                  }
                }
              },
              titleButton: 'DAFTAR',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
