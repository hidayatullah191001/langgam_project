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
