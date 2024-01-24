part of '../pages.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomFormUser(
                title: 'Nama depan',
                isMandatory: true,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: CustomFormUser(
                title: 'Nama belakang',
                isMandatory: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomFormUser(
          title: 'Nama tampilan',
          isMandatory: true,
        ),
        Text(
          'Nama ini yang akan ditampilkan di bagian akun dan ulasan',
          style: AppTheme.greyTextStyle.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomFormUser(
          title: 'Alamat email',
          isMandatory: true,
        ),
        const SizedBox(height: 30),
        Text(
          'Perubahan Kata Sandi',
          style: AppTheme.blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: AppTheme.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 3,
              color: AppColors.softgreyColor.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormUser(
                title:
                    'Kata sandi saat ini (biarkan kosong jika tidak ingin diubah)',
              ),
              const SizedBox(height: 20),
              CustomFormUser(
                title:
                    'Kata sandi baru (biarkan kosong jika tidak ingin diubah)',
              ),
              const SizedBox(height: 20),
              CustomFormUser(
                title: 'Konfirmasi kata sandi baru',
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        PrimaryButton(
          titleButton: 'SIMPAN PERUBAHAN',
          onTap: () {},
        ),
      ],
    );
  }
}
