import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:langgam_project/configs/configs.dart';
import 'package:langgam_project/controllers/controller.dart';
import 'package:langgam_project/graphql/client_provider.dart';
import 'package:langgam_project/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAccountController()),
        ChangeNotifierProvider(create: (_) => NavbarController()),
      ],
      child: const MyApp(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClientProvider(
//       uri: 'http://182.16.248.102:1337/graphql',
//       child: MaterialApp(
//         title: 'Coba GraphQL',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Layanans',
//             ),
//           ),
//           body: Query(
//             options: QueryOptions(
//               document: gql(LayananQuery.queryLayanans),
//             ),
//             builder: (result, {fetchMore, refetch}) {
//               if (result.isLoading) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (result.data == null) {
//                 return const Center(
//                   child: Text('Data not found'),
//                 );
//               }
//               final layanans = result.data!['layanans']['data'];
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: layanans.length,
//                 itemBuilder: (context, index) {
//                   final layanan = layanans[index];
//                   print(layanan['attributes']['judul']);
//                   return Text(layanan['attributes']['judul'].toString());
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BlogRow extends StatelessWidget {
//   final String title;
//   final String excerpt;
//   final String coverURL;

//   const BlogRow({
//     Key? key,
//     required this.title,
//     required this.excerpt,
//     required this.coverURL,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: coverURL != null
//                 ? Image.network(coverURL)
//                 : const FlutterLogo(),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   excerpt,
//                   style: Theme.of(context).textTheme.bodyText2,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.,
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: Constant.apigpl,
      child: MaterialApp(
        title: 'Langgam',
        initialRoute: '/admin/auth',
        routes: {
          '/': (context) => const IndexPage(),
          '/register': (context) => const RegisterPage(),
          '/my-account': (context) => const MyAccountPage(),
          '/layanan': (context) => const ProductLayananPage(),
          '/layanan/detail': (context) => DetailProductLayananPage(),
          '/cart': (context) => const CartPage(),
          '/cart/checkout': (context) => const CheckoutPage(),
          '/cart/checkout/finish': (context) => const CheckoutFinishPage(),
          '/berita': (context) => const BeritaPage(),
          '/berita/detail': (context) => const DetailBeritaPage(),
          '/admin/auth': (context) => const LoginAdminPage(),
          '/admin': (context) => const LoginAdminPage(),
        },
      ),
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
//       title: 'Flutter Navbar with Dropdown',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Navbar with Dropdown'),
//       ),
//       body: Center(
//         child: NavbarWithDropdown(),
//       ),
//     );
//   }
// }

// class NavbarWithDropdown extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         color: Colors.blue,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             NavItem(title: 'Home'),
//             NavItem(title: 'About'),
//             NavItem(title: 'Services', hasDropdown: true),
//             NavItem(title: 'Contact'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NavItem extends StatefulWidget {
//   final String title;
//   final bool hasDropdown;

//   NavItem({required this.title, this.hasDropdown = false});

//   @override
//   _NavItemState createState() => _NavItemState();
// }

// class _NavItemState extends State<NavItem> {
//   bool isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           isHovered = true;
//         });
//         _showMyDialog(context);
//       },
//       onExit: (_) {
//         setState(() {
//           isHovered = false;
//         });
//         Navigator.of(context).pop();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               widget.title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.0,
//               ),
//             ),
//             if (widget.hasDropdown) DropdownArrow(isHovered: isHovered),
//           ],
//         ),
//       ),
//     );
//   }

//   // Fungsi untuk menampilkan dialog
//   Future<void> _showMyDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Judul Dialog'),
//           content: Text('Isi dari dialog.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Tutup'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class DropdownArrow extends StatelessWidget {
//   final bool isHovered;

//   DropdownArrow({required this.isHovered});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       transform: isHovered ? Matrix4.rotationZ(0.5) : Matrix4.rotationZ(0),
//       child: const Icon(
//         Icons.arrow_drop_down,
//         color: Colors.white,
//       ),
//     );
//   }
// }

// class DropdownMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 100,
//       color: Colors.blue,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             title: Text('Option 1'),
//             onTap: () {
//               // Handle option 1
//             },
//           ),
//           ListTile(
//             title: Text('Option 2'),
//             onTap: () {
//               // Handle option 2
//             },
//           ),
//           // Add more ListTile widgets for additional options
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyWidget(),
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contoh ShowDialog dengan OverlayEntry'),
//       ),
//       body: Center(
//         child: MouseRegionWidget(),
//       ),
//     );
//   }
// }

// class MouseRegionWidget extends StatefulWidget {
//   @override
//   _MouseRegionWidgetState createState() => _MouseRegionWidgetState();
// }

// class _MouseRegionWidgetState extends State<MouseRegionWidget> {
//   GlobalKey _key = GlobalKey();
//   OverlayEntry? _overlayEntry;
//   bool _isMouseInside = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (event) {
//         // Menampilkan dialog ketika mouse masuk
//         _showMyDialog(context);
//         _isMouseInside = true;
//       },
//       onExit: (event) {
//         // Menutup dialog ketika mouse keluar
//         _isMouseInside = false;
//         _overlayEntry!.remove();
//       },
//       child: Container(
//         key: _key,
//         width: 100,
//         height: 100,
//         color: Colors.blue,
//         child: Center(
//           child: Text(
//             'Arahkan Mouse ke Sini',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _showMyDialog(BuildContext context) async {
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         width: 100,
//         height: 100,
//         child: MouseRegion(
//           onExit: (event) {
//             // Menutup dialog ketika mouse keluar dari dialog
//             if (!_isMouseInside) {
//               _overlayEntry!.remove();
//             }
//           },
//           child: Material(
//             color: Colors.transparent,
//             child: AlertDialog(
//               title: Text('Judul Dialog'),
//               content: Text('Isi dari dialog.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     _overlayEntry!.remove();
//                   },
//                   child: Text('Tutup'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyWidget(),
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   final _key = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contoh ShowDialog dengan Hovering'),
//       ),
//       body: Center(
//         child: HoverWidget(
//                 hoverChild: Container(
//                   height: 200,
//                   width: 200,
//                   color: Colors.green,
//                   child: Center(child: Text('Hover Me..')),
//                 ),
//                 onHover: (event) {
//                   _key.currentState?.showSnackBar(const SnackBar(
//                     content: Text('Yaay! I am Hovered'),
//                   ));
//                 },
//                 child: Container(
//                   height: 200,
//                   width: 200,
//                   color: Colors.red,
//                   child: Center(child: Text('Hover Me..')),
//                 ),
//               ),
//       ),
//     );
//   }

//   Future<void> _showMyDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Judul Dialog'),
//           content: Text('Isi dari dialog.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Tutup'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyWidget(),
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contoh ShowDialog dengan HoverWidget'),
//       ),
//       body: Center(
//         child: HoverDialogWidget(),
//       ),
//     );
//   }
// }

// class HoverDialogWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return HoverWidget(
//       onHover: (event) {
//         // Menampilkan dialog ketika mouse masuk
//         _showMyDialog(context);
//       },
//       hoverChild:
//           Container(), // Widget yang akan ditampilkan saat mouse di atasnya
//       child: Container(
//         width: 100,
//         height: 100,
//         color: Colors.blue,
//         child: Center(
//           child: Text(
//             'Arahkan Mouse ke Sini',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _showMyDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Judul Dialog'),
//           content: Text('Isi dari dialog.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Tutup'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
