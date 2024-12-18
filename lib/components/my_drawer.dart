import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:food_delivery/components/my_drawer_title.dart';
import 'package:food_delivery/service/auth/auth_service.dart';
import '../page/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Modificar el logout para redirigir después de cerrar sesión
  void logout(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signOut(); // Llamamos al servicio para cerrar sesión
      Navigator.pushReplacementNamed(context, '/login'); // Redirigimos al login
    } catch (e) {
      print("Error cerrando sesión: $e");
      // Puedes manejar el error de alguna forma, como mostrando un mensaje
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // app logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Lottie.asset(
              'assets/images/animaciones/Animation-1732378984857.json',
              height: 150, // Tamaño de la animación
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // home list title
          MyDrawerTitle(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          // settings list title
          MyDrawerTitle(
            text: "A J U S T E S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          const Spacer(),
          // logout list title
          MyDrawerTitle(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              logout(context); // Llamar a logout pasando el contexto
            },
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
