// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

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
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
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
              controller: ConfirmPasswordController,
              hintText: "Confirmar Contrasena",
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),

            //sign Up button
            MyButton(
              text: "registrarse",
              onTap: () {},
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
    );
  }
}
