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
        ChangeNotifierProvider(create: (_) => PencarianController()),
        ChangeNotifierProvider(create: (_) => SettingController()),
      ],
      child: MyApp(),
    ),
  );
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
