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
                    letterSpacing: 2,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
