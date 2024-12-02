// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_delivery/service/auth/auth_service.dart';
import 'package:lottie/lottie.dart';
import '../components/my_button.dart';
import '../components/my_texfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false; // Estado de carga

  void register() async {
    // Oculta el teclado
    FocusScope.of(context).unfocus();

    // Evita múltiples registros
    if (isLoading) return;

    setState(() {
      isLoading = true; // Activar indicador de carga
    });

    // Obtén el servicio de autenticación
    final authService = AuthService();

    try {
      // Verifica si las contraseñas coinciden
      if (passwordController.text == confirmPasswordController.text) {
        // Intenta crear el usuario
        await authService.signUpWithEmailPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Muestra un mensaje de éxito
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Registro exitoso"),
            content: Text("El usuario se ha registrado correctamente."),
          ),
        );
      } else {
        // Muestra un mensaje si las contraseñas no coinciden
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("¡Las contraseñas no coinciden!"),
          ),
        );
      }
    } catch (e) {
      // Muestra el error
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Desactivar indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Lottie.asset(
                'assets/images/animaciones/Animation-1732378984857.json',
                height: 250,
              ),
              const SizedBox(height: 25),

              // Mensaje de bienvenida
              Text(
                'Creemos una cuenta para ti',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // Email
              MyTexfield(
                controller: emailController,
                hintText: "Correo electrónico",
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // Contraseña
              MyTexfield(
                controller: passwordController,
                hintText: "Contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // Confirmar contraseña
              MyTexfield(
                controller: confirmPasswordController,
                hintText: "Confirmar contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 25),

              // Botón de registro
              isLoading
                  ? const CircularProgressIndicator() // Indicador de carga
                  : MyButton(
                      text: "Registrarse",
                      onTap: register,
                    ),
              const SizedBox(height: 25),

              // Redirección a inicio de sesión
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      'Inicia sesión ahora',
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
                  //     "Inicia sesión ahora",
                  //     style: TextStyle(
                  //       color: Theme.of(context).colorScheme.inversePrimary,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
