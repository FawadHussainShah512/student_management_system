// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import 'login/splash_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           apiKey: 'AIzaSyBJrAJLFfP4DD1Q5sA1m5tNliL-j3lov7U',
//           appId: '1:307652046877:android:b506aa8f5aad76cf33d6f4',
//           messagingSenderId: '307652046877',
//           projectId: 'studentlms-e9f95'));
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.blue.withOpacity(0.5),
//       statusBarColor: Colors.transparent,
//     ));
//
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: Scaffold(
//             backgroundColor: const Color(0xFF0B0C0B),
//             body: Stack(
//               children: <Widget>[
//                 Center(
//                   child: WidgetRingAnimator(
//                     size: 120,
//                     ringIcons: const [
//                       'assets/store.png',
//                       'assets/product.png',
//                       'assets/cart.png',
//                       'assets/rupee.png',
//                       'assets/delivery.png',
//                     ],
//                     ringIconsSize: 3,
//                     ringIconsColor: Colors.grey[200] ?? Colors.grey,
//                     ringAnimation: Curves.linear,
//                     ringColor: Colors.green,
//                     reverse: false,
//                     ringAnimationInSeconds: 10,
//                     child: ClipOval(
//                       child: Material(
//                         color: Colors.transparent,
//                         child: Ink.image(
//                           image: AssetImage('assets/images/splash.png'),
//                           fit: BoxFit.cover,
//                           width: 90.0.w, // Use Sizer for responsive width
//                           height: 90.0.h, // Use Sizer for responsive height
//                           child: InkWell(
//                             onTap: () {
//                               // Handle image tap if needed
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: AvatarGlow(
//                     glowColor: Colors.lightGreen,
//                     endRadius: 200.0,
//                     duration: Duration(milliseconds: 2000),
//                     repeat: true,
//                     showTwoGlows: true,
//                     repeatPauseDuration: Duration(milliseconds: 100),
//                     child: ClipOval(
//                       child: Material(
//                         color: Colors.transparent,
//                         child: Ink.image(
//                           image: AssetImage('assets/images/splash.png'),
//                           fit: BoxFit.cover,
//                           width: 90.0.w, // Use Sizer for responsive width
//                           height: 90.0.h, // Use Sizer for responsive height
//                           child: InkWell(
//                             onTap: () {
//                               // Handle image tap if needed
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; // Import the Sizer package

import 'onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBJrAJLFfP4DD1Q5sA1m5tNliL-j3lov7U',
          appId: '1:307652046877:android:b506aa8f5aad76cf33d6f4',
          messagingSenderId: '307652046877',
          projectId: 'studentlms-e9f95'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        // You can access the screen size using SizerUtil like SizerUtil.deviceScreenType, etc.

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
        );
      },
    );
  }
}
