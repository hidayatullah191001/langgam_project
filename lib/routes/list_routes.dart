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

class Routes {
  static String index = "/";
  static String register = "/register";
  static String myAccount = "/my-account";
  static String layanan = "/layanan";
  static String layananDetail = "/layanan/detail/:slug";
  static String cart = "/cart";
  static String checkout = "/cart/checkout";
  static String checkoutSuccess = "/cart/checkout/success";
  static String berita = "/berita";
  static String beritaDetail = "/berita/detail/:slug";
  static String adminAuth = "/admin/auth";
  static String admin = "/admin";

  // static String demoSimpleFixedTrans = "/demo/fixedtrans";
  // static String demoFunc = "/demo/func";
  // static String deepLink = "/message";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(index, handler: HandlerRoute.index);
    router.define(register, handler: HandlerRoute.register);
    router.define(myAccount, handler: HandlerRoute.myAccount);
    router.define(layanan, handler: HandlerRoute.layanan);
    router.define(layananDetail, handler: HandlerRoute.layananDetail);
    router.define(cart, handler: HandlerRoute.cart);
    router.define(checkout, handler: HandlerRoute.checkout);
    router.define(checkoutSuccess, handler: HandlerRoute.checkoutSuccess);
    router.define(berita, handler: HandlerRoute.berita);
    router.define(beritaDetail, handler: HandlerRoute.beritaDetail);
    router.define(adminAuth, handler: HandlerRoute.adminAuth);
    router.define(admin, handler: HandlerRoute.admin);

    // router.define(demoSimple, handler: demoRouteHandler);
    // router.define(demoSimpleFixedTrans,
    //     handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
    // router.define(demoFunc, handler: demoFunctionHandler);
    // router.define(deepLink, handler: deepLinkHandler);
  }
}
