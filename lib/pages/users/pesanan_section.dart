part of '../pages.dart';

class PesananSection extends StatelessWidget {
  const PesananSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PESANAN',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'TANGGAL',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'STATUS',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 30),
            Text(
              'TOTAL',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 40),
            Text(
              'AKSI',
              style: AppTheme.blackTextStyle.copyWith(
                fontWeight: AppTheme.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const Divider(),

        // Disini List Item Pesanan
        const ItemPesanan(),
        const ItemPesanan(),
      ],
    );
  }
}

class ItemPesanan extends StatelessWidget {
  const ItemPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyAccountController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: InkWell(
                child: Text(
                  '#16533',
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                'Januari 23,2024',
                style: AppTheme.softgreyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                'Menunggu persetujuan',
                style: AppTheme.softgreyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Rp166500',
                  style: AppTheme.primaryTextStyle.copyWith(
                    fontWeight: AppTheme.bold,
                  ),
                  children: [
                    TextSpan(
                        text: ' untuk 1 item',
                        style: AppTheme.softgreyTextStyle),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              titleButton: 'LIHAT',
              onTap: () {
                controller.pickMenu('Detail pesanan', 1);
              },
              fontSize: 12,
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class DetailPesananSection extends StatelessWidget {
  const DetailPesananSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Detail Pesanan Section',
      ),
    );
  }
}
