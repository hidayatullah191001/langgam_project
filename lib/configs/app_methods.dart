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

  static void dangerToast(BuildContext context, String title) async {
    toastification.show(
      context: context,
      title: Text(
        title,
        style: AppTheme.whiteTextStyle,
      ),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
    );
  }

  static void successToast(BuildContext context, String title) async {
    toastification.show(
      context: context,
      title: Text(
        title,
      ),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
    );
  }

  static void warningToast(BuildContext context, String title) async {
    toastification.show(
      context: context,
      title: Text(
        title,
      ),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
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

  static void openLinkNewTab(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String potongString({required String input, required int panjangMax}) {
    if (input.length <= panjangMax) {
      return input;
    } else {
      return input.substring(0, panjangMax - 3) + "...";
    }
  }

  // void sendEmail(String recipientEmail, String subject, String body) async {
  //   final smtpServer = gmail('your@gmail.com', 'your-password');

  //   final message = Message()
  //     ..from = Address('your@gmail.com', 'Your Name')
  //     ..recipients.add(recipientEmail)
  //     ..subject = subject
  //     ..text = body;

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
}
