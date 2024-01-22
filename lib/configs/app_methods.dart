part of 'configs.dart';

class AppMethods {
  static String date(String stringDate) {
    //2022-02-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  static String currency(String number) {
    return NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp ',
    ).format(double.parse(number));
  }

  static void dangerFlushbar(BuildContext context, String title) {
    Flushbar(
      backgroundColor: AppColors.dangerColor,
      title: 'Failed',
      titleColor: AppColors.warningColor,
      message: title,
      duration: const Duration(seconds: 3),
      isDismissible: false,
    ).show(context);
  }
}
