import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static FluroRouter berita = FluroRouter(); // FluroRouter pertama
  static FluroRouter detailBerita = FluroRouter(); // FluroRouter kedua

  static void defineBeritaRoutes() {
    berita.define(
      '/home',
      handler: Handler(
        handlerFunc: (context, parameters) {
          // Handle main route logic
        },
      ),
    );
    // Define other main routes as needed
  }

  // static void defineDetailBeritaRoutes() {
  //   detailBerita.define(
  //     '/detail/:slug',
  //     handler: Handler(
  //       handlerFunc: (context, parameters) {
  //         String slug = parameters['slug']?.first ?? '';
  //         Navigator.push(
  //           context!,
  //           MaterialPageRoute(
  //             builder: (context) =>
  //           ),
  //         );
  //       },
  //     ),
  //   );
  //   // Define other detail routes as needed
  // }

  //  static Widget handleCustomRoute(RouteSettings settings) {
  //   final customRoutes = {
  //     '/custom1': (BuildContext context) => CustomPage1(),
  //     '/custom2': (BuildContext context) => CustomPage2(),
  //     '/custom3': (BuildContext context) => CustomPage3(),
  //     // Add more custom routes as needed
  //   };

  //   final handler = customRoutes[settings.name];
  //   return handler?.call(settings.context!) ?? Container(); // Return Container for unknown routes
  // }
}
