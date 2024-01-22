part of 'widgets.dart';

class CustomFormUser extends StatefulWidget {
  final String title;
  bool isMandatory;
  bool isObscure;
  TextEditingController? controller;

  CustomFormUser({
    Key? key,
    required this.title,
    this.isMandatory = false,
    this.isObscure = false,
    this.controller,
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
          decoration: InputDecoration(
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

// class CustomFormUser extends StatelessWidget {
//   final String title;
//   bool isMandatory;
//   bool isObscure;
//   TextEditingController? controller;

//   CustomFormUser({
//     Key? key,
//     required this.title,
//     this.isMandatory = false,
//     this.isObscure = false,
//     this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextFormField(),
//     );
//   }
// }
