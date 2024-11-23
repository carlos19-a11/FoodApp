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

  void register() async {
    // Obtén el servicio de autenticación
    final authService = AuthService();

    // Verifica si las contraseñas coinciden
    if (passwordController.text == confirmPasswordController.text) {
      // Intenta crear el usuario
      try {
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );

        // Muestra un mensaje de éxito
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Registro exitoso"),
            content: Text("El usuario se ha registrado correctamente."),
          ),
        );
      } catch (e) {
        // Muestra el error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      // Muestra un mensaje si las contraseñas no coinciden
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("¡Las contraseñas no coinciden!"),
        ),
      );
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
              //logo
              Lottie.asset(
                'assets/images/animaciones/Animation-1732378984857.json',
                height: 250, // Tamaño de la animación
              ),
              const SizedBox(
                height: 25,
              ),
              //message, app slogan
              Text(
                'Creemos una cuenta para ti ',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(
                height: 25,
              ),
              //email textfield
              MyTexfield(
                controller: emailController,
                hintText: "Correo electrónico",
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),

              //password textfiled
              MyTexfield(
                controller: passwordController,
                hintText: "Contrasena",
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              //confirm password textfiled
              MyTexfield(
                controller: confirmPasswordController,
                hintText: "Confirmar Contrasena",
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),

              //sign Up button
              MyButton(
                text: "registrarse",
                onTap: register,
              ),
              const SizedBox(
                height: 25,
              ),
              //already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ya tienes una cuenta?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Inicia sesión ahora",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
