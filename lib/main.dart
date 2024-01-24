import 'package:flutter/material.dart';
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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Langgam',
      initialRoute: '/cart/checkout',
      routes: {
        '/': (context) => const IndexPage(),
        '/register': (context) => const RegisterPage(),
        '/my-account': (context) => const MyAccountPage(),
        '/layanan': (context) => const ProductLayananPage(),
        '/layanan/detail': (context) => const DetailProductLayananPage(),
        '/cart': (context) => const CartPage(),
        '/cart/checkout': (context) => const CheckoutPage(),
        '/cart/checkout/finish': (context) => const CheckoutFinishPage(),
      },
    );
  }
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () {
//               Scaffold.of(context).openEndDrawer();
//             },
//           ),
//         ),
//       ),
//       endDrawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('Item 1'),
//               onTap: () {
//                 // Handle drawer item click
//               },
//             ),
//             ListTile(
//               title: Text('Item 2'),
//               onTap: () {
//                 // Handle drawer item click
//               },
//             ),
//             // Add more ListTile widgets as needed
//           ],
//         ),
//       ),
//     );
//   }
// }
