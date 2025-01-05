import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/page/home_page.dart';
import 'package:food_delivery/page/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;

        if (user != null) {
          // Actualizar dinámicamente el modelo del usuario
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<UserModel>().updateUser(
                  user.displayName ?? 'Sin Nombre',
                  user.email ?? 'Correo desconocido',
                );
          });

          return const HomePage();
        }

        // Si no hay usuario autenticado, limpiar el modelo de usuario
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context
              .read<UserModel>()
              .updateUser('Usuario predeterminado', 'usuario@ejemplo.com');
        });

        return const LoginPage();
      },
    );
  }
}
