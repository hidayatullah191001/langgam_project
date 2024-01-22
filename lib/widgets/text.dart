part of 'widgets.dart';

class AutoExpandText extends StatelessWidget {
  String? text;
  final TextStyle style;

  AutoExpandText({
    this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text!,
        style: style,
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final List<String> items;

  BulletText({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => buildBulletItem(item)).toList(),
      ),
    );
  }

  Widget buildBulletItem(String item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.arrow_forward,
            size: 16,
            color: AppColors.textColor,
          ),
        ),
        Expanded(
          child: Text(
            item,
            style: AppTheme.greyTextStyle,
          ),
        ),
      ],
    );
  }
}
