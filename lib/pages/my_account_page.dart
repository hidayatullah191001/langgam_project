part of 'pages.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String stateLogin = 'MASUK';

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const BannerTop(),
            ]),
          ),
          const SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            collapsedHeight: 101.0,
            automaticallyImplyLeading: false,
            flexibleSpace: Navbar(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                HeroSection(
                  heroTitle: 'AKUN SAYA',
                  heroPosition: 'RUMAH  ',
                ),
                MyAccountSection(context),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
      endDrawer: const LoginDrawer(),
    );
  }

  Widget MyAccountSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundColor3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stateLogin == 'MASUK' ? LoginForm() : RegisterForm(),
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

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            title: 'Nama pengguna atau alamat email ',
            isMandatory: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormUser(
            title: 'Passwod',
            isObscure: true,
            isMandatory: true,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onTap: () {},
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

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          CustomFormUser(
            title: 'Alamat email ',
            isMandatory: true,
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
              onTap: () {},
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
