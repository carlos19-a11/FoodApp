// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_table.dart';
import 'package:food_delivery/page/dailyorderspage.dart';
import 'package:lottie/lottie.dart';
import 'package:food_delivery/components/my_drawer_title.dart';
import 'package:food_delivery/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // Obtener el usuario autenticado
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // Espacio para el correo y el icono
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ícono de persona
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircleAvatar(
                    radius: 20, // Tamaño del círculo
                    backgroundColor: Colors.transparent, // Sin color de fondo
                    backgroundImage: AssetImage(
                        'assets/images/animaciones/mujer-de-negocios.png'),
                  ),
                ),

                // Mostrar el correo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    user?.email ?? "Usuario no autenticado",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Animación del logo
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
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
          // Home list title
          MyDrawerTitle(
            text: "I N I C I O",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          MyDrawerTitle(
            text: "G E S T I Ó N  D E  M E S A S",
            icon: Icons.table_bar,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TableManagementPage(),
                ),
              );
            },
          ),
          MyDrawerTitle(
            text: "G E S T I Ó N  D E  P E D I D O S",
            icon: Icons.list,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersPage(),
                ),
              );
            },
          ),
          // Settings list title
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
          // Logout list title
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
