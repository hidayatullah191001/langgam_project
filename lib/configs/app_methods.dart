part of 'configs.dart';

class AppMethods {
  static String date(String stringDate) {
    //2022-02-05
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy HH:mm').format(dateTime);
  }

  static String currency(String number) {
    return NumberFormat.currency(
      decimalDigits: 2,
      locale: 'id_ID',
      symbol: 'Rp ',
    ).format(double.parse(number));
  }

  static String convertToTitleCase(String inputString) {
    List<String> words = inputString.toLowerCase().split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }

  static String generateOrderString(int length) {
    final random = Random();
    return List.generate(length, (index) => random.nextInt(10).toString())
        .join();
  }

  // static void dangerFlushbar(BuildContext context, String title) {
  //   Flushbar(
  //     backgroundColor: AppColors.dangerColor,
  //     title: 'Failed',
  //     titleColor: AppColors.whiteColor,
  //     message: title,
  //     duration: const Duration(seconds: 3),
  //     isDismissible: false,
  //     borderRadius: BorderRadius.circular(12),
  //   ).show(context);
  // }

  static void dangerToast(BuildContext context, String title) async {
    toastification.show(
      context: context,
      title: title,
      primaryColor: AppColors.whiteColor,
      backgroundColor: AppColors.dangerColor,
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
    );
  }

  static void successToast(BuildContext context, String title) async {
    toastification.show(
      context: context,
      title: title,
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.success,
    );
  }

  static void coolAlertDanger(BuildContext context, String text) {
    CoolAlert.show(
      context: context,
      width: MediaQuery.of(context).size.width * 0.3,
      type: CoolAlertType.error,
      text: text,
    );
  }
}
