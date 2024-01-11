import 'package:flutter/material.dart';
import 'package:flutter_form/data/preferences.dart';
import 'package:flutter_form/ui/dialogs.dart';

import '../core/routes.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final String title;

  LoginPage({super.key}) {
    title = 'Login Page';
  }

  LoginPage.withTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 20),
            TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username == 'admin' && password == 'admin') {
                    saveSessionData(username);
                    Navigator.pushReplacementNamed(context, Routes.records);
                  } else {
                    Dialogs(context).showAlert(
                        'Alerta',
                        const SingleChildScrollView(
                            child: ListBody(
                          children: [
                            Text('Username: Usuario y/o contraseña incorrectos')
                          ],
                        )));
                  }
                },
                child: const Text('Iniciar sesión'))
          ],
        ),
      ),
    );
  }
}
