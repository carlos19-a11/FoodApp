// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_texfield.dart';
import 'package:food_delivery/service/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // Liberar recursos cuando el widget se destruya
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    FocusScope.of(context).unfocus(); // Ocultar teclado

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, completa todos los campos.'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final _authService = AuthService();

    try {
      await _authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      if (!mounted) return; // Verificar si el widget está montado
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      print(
          'Error de autenticación: $e'); // Verificar si el widget está montado
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(getErrorMessage(e)),
        ),
      );
    } finally {
      // ignore: control_flow_in_finally
      if (!mounted) return; // Verificar si el widget está montado
      setState(() {
        isLoading = false;
      });
    }
  }

  String getErrorMessage(Object error) {
    if (error.toString().contains('user-not-found')) {
      return 'Usuario no encontrado. Regístrate primero.';
    } else if (error.toString().contains('wrong-password')) {
      return 'Contraseña incorrecta. Intenta nuevamente.';
    } else {
      return 'Algo salió mal. Por favor, intenta más tarde.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/animaciones/Animation-1732378984857.json',
                height: 250,
              ),
              const SizedBox(height: 25),
              Text(
                'Aplicación de entrega de comida',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),
              MyTexfield(
                controller: emailController,
                hintText: "Correo electrónico",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTexfield(
                controller: passwordController,
                hintText: "Contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButton(
                      onTap: login,
                      text: "Iniciar sesión",
                    ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes cuenta?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  // ElevatedButton(
                  //     onPressed: login, child: const Text('Iniciar sesión')),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      'Regístrate aquí',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary, // Esto depende del contexto
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: widget.onTap,
                  //   child: Text(
                  //     "Regístrate ahora",
                  //     style: TextStyle(
                  //       color: Theme.of(context).colorScheme.primary,
                  //       fontWeight: FontWeight.bold,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
