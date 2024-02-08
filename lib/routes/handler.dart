part of 'route.dart';

// return MaterialApp(
//       title: 'Langgam',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const IndexPage(),
//         '/register': (context) => const RegisterPage(),
//         '/my-account': (context) => const MyAccountPage(),
//         '/layanan': (context) => const ProductLayananPage(),
//         '/layanan/detail': (context) => DetailProductLayananPage(),
//         '/cart': (context) => const CartPage(),
//         '/cart/checkout': (context) => const CheckoutPage(),
//         '/cart/checkout/finish': (context) => const CheckoutFinishPage(),
//         '/berita': (context) => const BeritaPage(),
//         '/berita/detail': (context) => const DetailBeritaPage(),
//         '/admin/auth': (context) => const LoginAdminPage(),
//         '/admin': (context) => const AppAdminPage(),
//       },
//     );
class HandlerRoute {
  static final index = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const IndexPage(),
  );

  static final register = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const RegisterPage(),
  );

  static final myAccount = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const MyAccountPage(),
  );

  static final layanan = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    String? slugBidangLayanan = params["bidang_layanan"]?.first;

    return ProductLayananPage(slugBidangLayanan: slugBidangLayanan);
  });

  static final layananDetail = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    String? slug = params["slug"]?.first;
    String? id = params['id']?.first;

    return DetailProductLayananPage(slug: slug!, id: id!);
  });

  static final cart = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    // String? name = params["name"]?.first;
    return CartPage();
  });

  static final checkout = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const CheckoutPage(),
  );

  static final checkoutSuccess = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const CheckoutFinishPage(),
  );

  static final berita = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const BeritaPage(),
  );

  static final beritaDetail = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const DetailBeritaPage(),
  );

  static final adminAuth = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const LoginAdminPage(),
  );

  static final admin = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const AppAdminPage(),
  );
}


// var demoRouteHandler = Handler(
//     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
//   String? message = params["message"]?.first;
//   String? colorHex = params["color_hex"]?.first;
//   String? result = params["result"]?.first;
//   Color color = Color(0xFFFFFFFF);
//   if (colorHex != null && colorHex.length > 0) {
//     color = Color(ColorHelpers.fromHexString(colorHex));
//   }
//   return DemoSimpleComponent(
//       message: message ?? 'Testing', color: color, result: result);
// });