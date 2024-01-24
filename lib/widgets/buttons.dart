part of 'widgets.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String titleButton;
  double fontSize;
  PrimaryButton({
    Key? key,
    required this.onTap,
    required this.titleButton,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 13,
          ),
          child: Text(
            titleButton.toUpperCase(),
            style: AppTheme.whiteTextStyle.copyWith(
              fontWeight: AppTheme.medium,
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String titleButton;
  double fontSize;
  SecondaryButton({
    Key? key,
    required this.onTap,
    required this.titleButton,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backgroundColor2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 13,
          ),
          child: Text(
            titleButton.toUpperCase(),
            style: AppTheme.whiteTextStyle.copyWith(
              fontWeight: AppTheme.medium,
              fontSize: fontSize,
              color: AppColors.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class TextButtonHovered extends StatefulWidget {
  int? index;
  final String text;
  final VoidCallback onTap;
  TextStyle? styleHovered;
  TextStyle? styleBeforeHovered;
  TextButtonHovered({
    super.key,
    this.index = 0,
    required this.text,
    required this.onTap,
    this.styleHovered,
    this.styleBeforeHovered,
  });

  @override
  State<TextButtonHovered> createState() => _TextButtonHoveredState();
}

class _TextButtonHoveredState extends State<TextButtonHovered> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: isHovered
              ? widget.styleHovered ??
                  AppTheme.whiteTextStyle.copyWith(fontWeight: AppTheme.bold)
              : widget.styleBeforeHovered ??
                  AppTheme.softgreyTextStyle.copyWith(
                    fontWeight: AppTheme.semiBold,
                  ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      isHovered = hover;
    });
  }
}
