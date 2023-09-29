import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica de inicio de sesión
                // por ejemplo, validar las credenciales, enviar una solicitud
                // a un servidor, etc.
                String email = _emailController.text;
                String password = _passwordController.text;
                // Lógica de inicio de sesión aquí
              },
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
