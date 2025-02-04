import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cartmodel.dart';
import 'package:food_delivery/models/ordenmodel.dart';
import 'package:food_delivery/page/home_page.dart';
import 'package:food_delivery/page/login_page.dart';
import 'package:food_delivery/page/register_page.dart';
import 'package:food_delivery/service/auth/auth_gate.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Verificar si no estamos en Windows antes de inicializar Firebase
  if (!Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.setLanguageCode('es'); // Cambiar a español
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
        ChangeNotifierProvider(
            create: (context) => CartModel()), // Agregar CartModel aquí
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
    _startLogoutTimer(); // Inicia el temporizador cuando la app arranca
  }

  @override
  void dispose() {
    _logoutTimer?.cancel(); // Cancela el temporizador al cerrar la app
    super.dispose();
  }

  // Inicia el temporizador para cerrar sesión después de 5 minutos de inactividad
  void _startLogoutTimer() {
    const timeoutDuration = Duration(minutes: 30); // Tiempo sin interacción
    _logoutTimer = Timer(timeoutDuration, _handleAutoLogout);
  }

  // Función para manejar el cierre automático de sesión
  Future<void> _handleAutoLogout() async {
    // Cerrar sesión en Firebase
    await FirebaseAuth.instance.signOut();

    // Restablecer estado del usuario en el UserModel
    Provider.of<UserModel>(context, listen: false).updateUser(
      'Usuario predeterminado',
      'usuario@ejemplo.com',
    );

    // Redirigir al usuario al login usando el navigatorKey
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushReplacementNamed('/login');
    }
  }

  // Reinicia el temporizador de cierre de sesión cuando el usuario interactúa
  void _resetLogoutTimer() {
    _logoutTimer?.cancel();
    _startLogoutTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          _resetLogoutTimer, // Reiniciar el temporizador al tocar cualquier parte de la pantalla
      child: MaterialApp(
        navigatorKey: navigatorKey, // Usar el GlobalKey aquí
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthGate(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
        },
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    );
  }
}
