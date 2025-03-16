import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/models/cartmodel.dart';
import 'package:food_delivery/models/ordenmodel.dart';
import 'package:food_delivery/page/add_product_page.dart';
import 'package:food_delivery/page/home_page.dart';
import 'package:food_delivery/page/login_page.dart';
import 'package:food_delivery/page/register_page.dart';
import 'package:food_delivery/service/auth/auth_gate.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/service/product_service.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.setLanguageCode('es');
  } else {
    debugPrint('Firebase no está configurado para Windows.');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Restaurant()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => OrderModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => FoodService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _logoutTimer;

  @override
  void initState() {
    super.initState();
    _startLogoutTimer();
  }

  @override
  void dispose() {
    _logoutTimer?.cancel();
    super.dispose();
  }

  void _startLogoutTimer() {
    const timeoutDuration = Duration(minutes: 30);
    _logoutTimer = Timer(timeoutDuration, _handleAutoLogout);
  }

  Future<void> _handleAutoLogout() async {
    await FirebaseAuth.instance.signOut();
    Provider.of<UserModel>(context, listen: false).updateUser(
      'Usuario predeterminado',
      'usuario@ejemplo.com',
    );

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushReplacementNamed('/login');
    }
  }

  void _resetLogoutTimer() {
    _logoutTimer?.cancel();
    _startLogoutTimer();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Tamaño base (iPhone X)
      minTextAdapt: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: _resetLogoutTimer,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const AuthGate(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/home': (context) => const HomePage(),
              '/add_food': (context) => const AddFoodPage(),
            },
            theme: Provider.of<ThemeProvider>(context).themeData,
          ),
        );
      },
    );
  }
}
