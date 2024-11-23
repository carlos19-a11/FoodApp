// ignore_for_file: deprecated_member_use, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

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
  //  text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login() async {
    // get instance of auth service
    final _authService = AuthService();

    // try sing in
    try {
      await _authService.signInWithEmailPassword(
          emailController.text, passwordController.text);
    }

    // display any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
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
              // Lottie animation
              Lottie.asset(
                'assets/images/animaciones/Animation-1732378984857.json',
                height: 250, // Tamaño de la animación
              ),
              const SizedBox(
                height: 25,
              ),
              //message, app slogan
              Text(
                'Aplicación de entrega de comida',
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
              //sign in button
              MyButton(
                onTap: login,
                text: "Iniciar sesión",
              ),
              const SizedBox(
                height: 25,
              ),
              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No soy miembro?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Regístrate ahora ",
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
