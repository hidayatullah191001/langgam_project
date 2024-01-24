part of '../pages.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyAccountController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat berikut akan digunakan pada halaman checkout secara otomatis',
          style: AppTheme.greyTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Untuk Alamat Penagihan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ALAMAT PENAGIHAN',
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.bold,
                          letterSpacing: 1.08,
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButtonHovered(
                        text: 'Tambahkan',
                        onTap: () {
                          controller.pickMenu('Alamat penagihan', 4);
                        },
                        styleBeforeHovered: AppTheme.greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        styleHovered: AppTheme.primaryTextStyle
                            .copyWith(fontSize: 12, fontWeight: AppTheme.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Anda belum mengatur jenis alamat ini',
                    style: AppTheme.greyTextStyle.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ALAMAT PENGIRIMAN',
                        style: AppTheme.blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: AppTheme.bold,
                          letterSpacing: 1.08,
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButtonHovered(
                        text: 'Tambahkan',
                        onTap: () {
                          controller.pickMenu('Alamat pengiriman', 4);
                        },
                        styleBeforeHovered: AppTheme.greyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                        styleHovered: AppTheme.primaryTextStyle
                            .copyWith(fontSize: 12, fontWeight: AppTheme.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Anda belum mengatur jenis alamat ini',
                    style: AppTheme.greyTextStyle.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AlamatPenagihanSection extends StatelessWidget {
  const AlamatPenagihanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat penagihan',
          style: AppTheme.blackTextStyle.copyWith(
              fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomFormUser(
                title: 'Nama depan',
                isMandatory: true,
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              child: CustomFormUser(
                title: 'Nama belakang',
                isMandatory: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        CustomFormUser(
          title: 'Nama perusahaan (opsional)',
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Text('Negara/Wilayah', style: AppTheme.blackTextStyle),
            Text(
              '*',
              style: AppTheme.blackTextStyle.copyWith(
                color: AppColors.dangerColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text('Indonesia', style: AppTheme.greyTextStyle),
        const SizedBox(height: 15),

        // Provinsi

        //Kota / Kabupaten

        // Kecamatan (opsional)
        CustomFormUser(
          title: 'Alamat jalan',
          isMandatory: true,
          hintText: 'Nomor rumah dan nama jalan',
        ),
        const SizedBox(height: 15),
        CustomFormUser(
          title: 'Kode pos',
          isMandatory: true,
        ),
        const SizedBox(height: 15),
        CustomFormUser(
          title: 'Telepon',
          isMandatory: true,
        ),
        const SizedBox(height: 15),
        CustomFormUser(
          title: 'Alamat email',
          isMandatory: true,
        ),
        const SizedBox(
          height: 20,
        ),
        PrimaryButton(onTap: () {}, titleButton: 'Simpan Alamat'),
      ],
    );
  }
}

class AlamatPengirimanSection extends StatelessWidget {
  const AlamatPengirimanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat pengiriman',
          style: AppTheme.blackTextStyle.copyWith(
              fontSize: 20, fontWeight: AppTheme.bold, letterSpacing: 1.2),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomFormUser(
                title: 'Nama depan',
                isMandatory: true,
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              child: CustomFormUser(
                title: 'Nama belakang',
                isMandatory: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        CustomFormUser(
          title: 'Nama perusahaan (opsional)',
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Text('Negara/Wilayah', style: AppTheme.blackTextStyle),
            Text(
              '*',
              style: AppTheme.blackTextStyle.copyWith(
                color: AppColors.dangerColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text('Indonesia', style: AppTheme.greyTextStyle),
        const SizedBox(height: 15),

        // Provinsi

        //Kota / Kabupaten

        // Kecamatan (opsional)
        CustomFormUser(
          title: 'Alamat jalan',
          isMandatory: true,
          hintText: 'Nomor rumah dan nama jalan',
        ),
        const SizedBox(height: 15),
        CustomFormUser(
          title: 'Kode pos',
          isMandatory: true,
        ),
        const SizedBox(height: 20),
        PrimaryButton(onTap: () {}, titleButton: 'Simpan Alamat'),
      ],
    );
  }
}
