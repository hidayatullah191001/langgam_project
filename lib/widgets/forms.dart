part of 'widgets.dart';

class CustomFormUser extends StatefulWidget {
  final String title;
  bool isMandatory;
  bool isObscure;
  TextEditingController? controller;
  int minLines;
  int maxLines;
  String? hintText;
  VoidCallback? onTap;
  TextInputType? keyboardType;

  CustomFormUser({
    Key? key,
    required this.title,
    this.isMandatory = false,
    this.isObscure = false,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.hintText,
    this.onTap,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomFormUser> createState() => _CustomFormUserState();
}

class _CustomFormUserState extends State<CustomFormUser> {
  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.title, style: AppTheme.blackTextStyle),
            widget.isMandatory
                ? Text(
                    '*',
                    style: AppTheme.blackTextStyle.copyWith(
                      color: AppColors.dangerColor,
                    ),
                  )
                : const Text(''),
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscure ? _isPasswordHidden : false,
          minLines: widget.minLines,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTheme.greyTextStyle.copyWith(
              fontSize: 12,
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.greyColor, width: 2),
              borderRadius: BorderRadius.circular(7),
            ),
            suffixIcon: widget.isObscure
                ? IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
