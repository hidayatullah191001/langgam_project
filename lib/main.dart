import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:langgam_project/configs/configs.dart';
import 'package:langgam_project/controllers/controller.dart';
import 'package:langgam_project/pages/pages.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAccountController()),
        ChangeNotifierProvider(create: (_) => NavbarController()),
        ChangeNotifierProvider(create: (_) => AdminController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => WilayahController()),
        ChangeNotifierProvider(create: (_) => LayananController()),
        ChangeNotifierProvider(create: (_) => CheckoutController()),
        ChangeNotifierProvider(create: (_) => PermintaanController()),
        ChangeNotifierProvider(create: (_) => BeritaController()),
        ChangeNotifierProvider(create: (_) => BantuanController()),
        ChangeNotifierProvider(create: (_) => LogbookController()),
      ],
      child: MyApp(),
    ),
  );
}

// class MyApp extends StatefulWidget {
//   @override
//   State createState() {
//     return MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   MyAppState() {
//     final router = FluroRouter();
//     Routes.configureRoutes(router);
//     Application.router = router;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final app = MaterialApp(
//       title: 'Langgam',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       onGenerateRoute: Application.router.generator,
//     );
//     return app;
//   }
// }

// class AppRoutes {
//   static const String root = 'root';
//   static const String login = 'login';

//   void setup() {
//     QR.settings.enableDebugLog = true;
//     QR.settings.autoRestoration = true;

//     QR.settings.notFoundPage = QRoute(
//       path: 'path',
//       builder: () => const ErrorPage(),
//     );
//     QR.observer.onNavigate.add((path, route) async {
//       debugPrint('Observer: Navigating to $path');
//     });
//     QR.observer.onPop.add((path, route) async {
//       debugPrint('Observer: popping out from $path');
//     });
//     QR.settings.pagesType = const QFadePage();
//   }

//   final routes = <QRoute>[
//     QRoute(
//       path: '/',
//       name: root,
//       builder: () => const IndexPage(),
//     ),
//     QRoute(
//       path: '/admin/auth',
//       name: login,
//       middleware: [
//         AuthMiddleware(),
//       ],
//       builder: () => const LoginAdmin(),
//     ),
//   ];
// }

// class LoginAdmin extends StatelessWidget {
//   const LoginAdmin({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final appRoutes = AppRoutes();
//     appRoutes.setup();
//     return MaterialApp.router(
//       // Add the [QRouteInformationParser]
//       routeInformationParser: const QRouteInformationParser(),
//       // Add the [QRouterDelegate] with your routes
//       routerDelegate: QRouterDelegate(
//         appRoutes.routes,
//       ),
//       theme: ThemeData(colorSchemeSeed: Colors.indigo),
//       restorationScopeId: 'app',
//     );
//   }
// }

// class AuthMiddleware extends QMiddleware {
//   final dataStorage = AppSession.getRoleLogin();

//   @override
//   Future<String?> redirectGuard(String path) async =>
//       dataStorage != 'admin' ? null : '/admin';
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerDelegate: QRouterDelegate(
//         routes: [
//           QRoute(
//             path: Routes.index,
//             builder: () => Scaffold(body: Center(child: Text('Index Page'))),
//           ),
//           QRoute(
//             path: Routes.admin,
//             middleware: [
//               (QMiddleware next) async {
//                 // Check if user is authenticated as admin
//                 // Replace this logic with your authentication logic
//                 final isAdmin = true; // Example: assuming user is admin
//                 if (isAdmin) {
//                   next();
//                 } else {
//                   // Redirect to login page or show unauthorized access message
//                   Q.to(Routes.adminAuth);
//                 }
//               },
//             ],
//             builder: () => Scaffold(body: Center(child: Text('Admin Page'))),
//           ),
//         ],

//         // Routes.register: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Register Page'))),
//         // ),
//         // Routes.myAccount: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('My Account Page'))),
//         // ),
//         // Routes.layanan: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Layanan Page'))),
//         // ),
//         // Routes.layananDetail: QRoute(
//         //   builder: (ctx) {
//         //     final slug = ctx.pathParams['slug'];
//         //     return Scaffold(body: Center(child: Text('Layanan Detail Page for $slug')));
//         //   },
//         // ),
//         // Routes.cart: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Cart Page'))),
//         // ),
//         // Routes.checkout: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Checkout Page'))),
//         // ),
//         // Routes.checkoutSuccess: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Checkout Success Page'))),
//         // ),
//         // Routes.berita: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Berita Page'))),
//         // ),
//         // Routes.beritaDetail: QRoute(
//         //   builder: (ctx) {
//         //     final slug = ctx.pathParams['slug'];
//         //     return Scaffold(body: Center(child: Text('Berita Detail Page for $slug')));
//         //   },
//         // ),
//         // Routes.adminAuth: QRoute(
//         //   builder: () => Scaffold(body: Center(child: Text('Admin Authentication Page'))),
//         // ),
//       ),
//       routeInformationParser: QRouteInformationParser(),
//     );
//   }
// }

// class Routes {}

// class AppRoutes {
//   static String index = "/";
//   static String register = "/register";
//   static String myAccount = "/my-account";
//   static String layanan = "/layanan";
//   static String layananDetail = "/layanan/detail/:slug";
//   static String cart = "/cart";
//   static String checkout = "/cart/checkout";
//   static String checkoutSuccess = "/cart/checkout/success";
//   static String berita = "/berita";
//   static String beritaDetail = "/berita/detail/:slug";
//   static String adminAuth = "/admin/auth";
//   static String admin = "/admin";

//   void setup() {
//     QR.settings.enableDebugLog = false;
//     QR.settings.autoRestoration = true;
//     QR.settings.notFoundPage = QRoute(
//       path: 'path',
//       builder: () => const ErrorPage(),
//     );
//   }

//   final routes = <QRoute>[
//     QRoute(
//       path: index,
//       name: 'index',
//       builder: () => const IndexPage(),
//     ),
//     QRoute(
//       path: register,
//       name: 'register',
//       builder: () => const RegisterPage(),
//     ),
//     QRoute(
//       path: '/layanan',
//       name: 'layanan',
//       builder: () => ProductLayananPage(),
//     ),
//     QRoute(
//       path: '/layanan/detail/:slug',
//       name: 'detail-layanan',
//       builder: () => DetailProductLayananPage(),
//     ),
//     QRoute(
//         path: '/auth',
//         name: 'adminAuth',
//         builder: () => const LoginAdminPage(),
//         middleware: [
//           QMiddlewareBuilder(
//             redirectGuardFunc: (_) async {
//               final role = await AppSession.getRoleLogin();
//               print('role $role');
//               if (role == 'admin' || role != null) {
//                 return QR.to('/auth/admin');
//               } else {
//                 return QR.to('/auth');
//               }
//             },
//           )
//         ],
//         children: [
//           QRoute(
//             path: '/admin',
//             name: 'admin',
//             builder: () => const AppAdminPage(),
//           ),
//         ]),
//   ];
// }

class LoginInfo extends ChangeNotifier {
  /// The username of login.
  String get userName => _userName;
  String _userName = '';

  /// Whether a user has logged in.
  bool get loggedIn => _userName.isNotEmpty;

  /// Logs in a user.
  void login(String userName) {
    _userName = userName;
    notifyListeners();
  }

  /// Logs out the current user.
  void logout() {
    _userName = '';
    notifyListeners();
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const IndexPage();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'layanan',
            builder: (BuildContext context, GoRouterState state) {
              return ProductLayananPage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'detail/:slug',
                builder: (context, GoRouterState state) {
                  return DetailProductLayananPage(
                      slug: state.pathParameters['slug']!);
                },
              ),
            ]),
        GoRoute(
          path: 'layanan/:slug',
          builder: (context, GoRouterState state) {
            return ProductLayananPage(
              slugBidangLayanan: state.pathParameters['slug']!,
            );
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterPage();
          },
        ),
        GoRoute(
          path: 'cart',
          builder: (BuildContext context, GoRouterState state) {
            return CartPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'checkout',
              redirect: (context, state) async {
                final role = await AppSession.getRoleLogin();
                if ((role != 'customer' || role == null) &&
                    state.matchedLocation == '/cart/checkout') {
                  return '/register';
                }
              },
              builder: (BuildContext context, GoRouterState state) {
                return CheckoutPage();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'success/:success',
                  redirect: (context, state) async {
                    bool isSuccess =
                        bool.parse(state.pathParameters['success']!);

                    final role = await AppSession.getRoleLogin();
                    final String? stringDataCart =
                        await AppSession.getDataCartUser();
                    List dataCart = json.decode(stringDataCart.toString());
                    print(isSuccess);
                    if ((role != 'customer' || role.isEmpty) &&
                        state.matchedLocation == '/cart/checkout/success') {
                      return '/register';
                    } else if (state.matchedLocation ==
                            '/cart/checkout/success' &&
                        dataCart.length > 0 &&
                        role == 'customer') {
                      return '/cart/checkout';
                    } else if (isSuccess != true) {
                      return '/cart/checkout';
                    }
                  },
                  builder: (BuildContext context, GoRouterState state) {
                    print(state.matchedLocation);
                    return CheckoutFinishPage();
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: 'my-account',
          redirect: (context, state) async {
            final role = await AppSession.getRoleLogin();
            print(state.matchedLocation);

            if (state.matchedLocation == '/my-account') {
              if (role.isEmpty) {
                return '/register';
              } else {
                if (role == 'authenticated') {
                  return '/auth/admin';
                } else if (role == 'customer') {
                  return '/my-account';
                } else {
                  return '/register';
                }
              }
            }
          },
          builder: (context, state) {
            return MyAccountPage();
          },
        ),
        GoRoute(
          path: 'auth',
          redirect: (context, state) async {
            final role = await AppSession.getRoleLogin();
            if (state.matchedLocation == '/auth') {
              if (role.isEmpty) {
                return '/auth';
              } else {
                if (role == 'customer') {
                  return '/';
                } else if (role == 'authenticated') {
                  return '/auth/admin';
                } else {
                  return '/auth';
                }
              }
            }
          },
          builder: (context, state) {
            return LoginAdminPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'admin',
              builder: (context, state) {
                return AppAdminPage();
              },
              redirect: (context, state) async {
                final role = await AppSession.getRoleLogin();
                print(role);
                if ((role != 'authenticated' || role.isEmpty) &&
                    state.matchedLocation == '/auth/admin') {
                  return '/auth';
                } else {
                  return '/auth/admin';
                }
              },
            )
          ],
        ),
        GoRoute(
          path: 'berita',
          builder: (context, state) => const BeritaPage(),
        ),
        GoRoute(
          path: 'berita/:slug',
          builder: (context, state) {
            final slug = state.pathParameters['slug']!;
            return DetailBeritaPage(
              slug: slug,
            );
          },
        ),
        GoRoute(
          path: 'bantuan/:slug',
          builder: (context, state) {
            final slug = state.pathParameters['slug']!;
            return BantuanPage(slug: slug);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Langgam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}
