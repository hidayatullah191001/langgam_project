part of 'widgets.dart';

class LoginDrawer extends StatefulWidget {
  const LoginDrawer({Key? key}) : super(key: key);

  @override
  State<LoginDrawer> createState() => _LoginDrawerState();
}

class _LoginDrawerState extends State<LoginDrawer> {
  bool _isPasswordHidden = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Mutation(
            options: MutationOptions(document: gql(AuthQuery.login)),
            builder: (runMutation, result) {
              // print(result!.data);
              // if (result!.data != null) {

              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MASUK',
                          style: AppTheme.blackTextStyle.copyWith(
                            fontWeight: AppTheme.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.close,
                                color: AppColors.blackColor,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Tutup',
                                style: AppTheme.blackTextStyle
                                    .copyWith(fontWeight: AppTheme.medium),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.greyColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormUser(
                          controller: emailController,
                          title: 'Nama pengguna atau alamat email ',
                          isMandatory: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormUser(
                          controller: passwordController,
                          title: 'Passwod',
                          isObscure: true,
                          isMandatory: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            onTap: () {
                              runMutation({
                                'identifier': emailController.text,
                                'password': passwordController.text,
                              });
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
                            Container(
                              width: 30,
                              height: 1,
                              color: AppColors.greyColor,
                            ),
                            Text(
                              'ATAU LOGIN DENGAN',
                              style: AppTheme.blackTextStyle.copyWith(
                                fontWeight: AppTheme.bold,
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 1,
                              color: AppColors.greyColor,
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
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'images/google-icon.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'GOOGLE',
                                            style: AppTheme.whiteTextStyle
                                                .copyWith(
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
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: AppColors.greyColor,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.circleUser,
                                  color: Color(0xfff1f1f1),
                                  size: 70,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Belum punya akun?',
                                  style: AppTheme.blackTextStyle
                                      .copyWith(fontWeight: AppTheme.bold),
                                ),
                                const SizedBox(height: 20),
                                TextButtonHovered(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  text: 'BUAT AKUN',
                                  styleHovered:
                                      AppTheme.blackTextStyle.copyWith(
                                    fontWeight: AppTheme.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: AppColors.greyColor,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
