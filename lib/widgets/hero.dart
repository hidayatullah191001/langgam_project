part of 'widgets.dart';

class HeroSection extends StatelessWidget {
  final String heroTitle;
  String? heroPosition;
  HeroSection({
    super.key,
    required this.heroTitle,
    this.heroPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppColors.primaryColor,
      child: Column(
        children: [
          Text(
            heroTitle,
            style: AppTheme.whiteTextStyle.copyWith(
              fontSize: 35,
              fontWeight: AppTheme.bold,
            ),
          ),
          heroPosition != null ? const SizedBox(height: 15) : const SizedBox(),
          heroPosition != null
              ? Text(
                  '$heroPosition / $heroTitle',
                  style: AppTheme.whiteTextStyle.copyWith(
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class HeroSectionCart extends StatelessWidget {
  String? heroPosition;
  HeroSectionCart({
    super.key,
    this.heroPosition,
  });

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)!.settings.name!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButtonHovered(
            text: 'KERANJANG BELANJA',
            onTap: () {
              if (currentRoute == '/cart/checkout') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/cart');
              }
            },
            styleBeforeHovered: heroPosition == 'KERANJANG BELANJA'
                ? AppTheme.whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: AppTheme.bold,
                  )
                : AppTheme.greyTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: AppTheme.bold,
                    color: AppColors.softgreyColor,
                  ),
            styleHovered: AppTheme.whiteTextStyle.copyWith(
              fontSize: 20,
              fontWeight: AppTheme.bold,
            ),
          ),
          const SizedBox(width: 20),
          const Icon(
            Icons.arrow_right_alt_sharp,
            color: AppColors.softgreyColor,
          ),
          const SizedBox(width: 20),
          TextButtonHovered(
            text: 'PEMESANAN',
            onTap: () {
              if (currentRoute == '/cart') {
                Navigator.pushNamed(context, '/cart/checkout');
              } else {
                Navigator.pop(context);
              }
            },
            styleBeforeHovered: heroPosition == 'PEMESANAN'
                ? AppTheme.whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: AppTheme.bold,
                  )
                : AppTheme.greyTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: AppTheme.bold,
                    color: AppColors.softgreyColor,
                  ),
            styleHovered: AppTheme.whiteTextStyle.copyWith(
              fontSize: 20,
              fontWeight: AppTheme.bold,
            ),
          ),
          const SizedBox(width: 20),
          const Icon(
            Icons.arrow_right_alt_sharp,
            color: AppColors.softgreyColor,
          ),
          const SizedBox(width: 20),
          Text(
            'SELESAI',
            style: heroPosition == 'SELESAI'
                ? AppTheme.whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: AppTheme.bold,
                  )
                : AppTheme.greyTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: AppTheme.bold,
                    color: AppColors.softgreyColor,
                  ),
          ),
        ],
      ),
    );
  }
}
