part of '../pages.dart';

class AccountSettingsSection extends StatefulWidget {
  const AccountSettingsSection({Key? key}) : super(key: key);

  @override
  State<AccountSettingsSection> createState() => _AccountSettingsSectionState();
}

class _AccountSettingsSectionState extends State<AccountSettingsSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserAccountController>().getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserAccountController controller, widget) {
        if (controller.dataState == DataState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.dataState == DataState.error) {
          return const Center(child: Text('Something went wrong'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Flexible(
              //       child: CustomFormUser(
              //         title: 'Nama depan',
              //         isMandatory: true,
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     Flexible(
              //       child: CustomFormUser(
              //         title: 'Nama belakang',
              //         isMandatory: true,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              CustomFormUser(
                controller  : controller.usernameController,
                title: 'Username',
                isMandatory: true,
                isEnabled : false,
              ),
              Text(
                'Nama ini yang akan ditampilkan di bagian akun',
                style: AppTheme.greyTextStyle.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormUser(
                controller : controller.emailController,
                title: 'Alamat email',
                isMandatory: true,
                isEnabled : false,
              ),
              const SizedBox(height: 30),
              // Text(
              //   'Perubahan Kata Sandi',
              //   style: AppTheme.blackTextStyle.copyWith(
              //     fontSize: 18,
              //     fontWeight: AppTheme.bold,
              //     letterSpacing: 1.2,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Container(
              //   padding: const EdgeInsets.all(30),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(
              //       width: 3,
              //       color: AppColors.softgreyColor.withOpacity(0.2),
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       CustomFormUser(
              //         title:
              //             'Kata sandi saat ini (biarkan kosong jika tidak ingin diubah)',
              //       ),
              //       const SizedBox(height: 20),
              //       CustomFormUser(
              //         title:
              //             'Kata sandi baru (biarkan kosong jika tidak ingin diubah)',
              //       ),
              //       const SizedBox(height: 20),
              //       CustomFormUser(
              //         title: 'Konfirmasi kata sandi baru',
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 25),
              // PrimaryButton(
              //   titleButton: 'SIMPAN PERUBAHAN',
              //   onTap: () {},
              // ),
            ],
          );
        }
      },
    );
  }
}
