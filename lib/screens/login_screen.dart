import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Importamos el cerebro

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Instanciamos el servicio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/2560px-Google_2015_logo.svg.png', height: 30),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Correo", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      // Llamada al servicio para CREAR CUENTA
                      await _authService.signUp(_emailController.text, _passwordController.text);
                    },
                    child: const Text("Crear cuenta"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Llamada al servicio para ENTRAR
                      await _authService.signIn(_emailController.text, _passwordController.text);
                    },
                    child: const Text("Siguiente"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}