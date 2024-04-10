import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'signUpPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String nome = ''; // Variável para armazenar o nome digitado
    String senha = ''; // Variável para armazenar a senha digitada

    // Definindo uma paleta de cores personalizada
    const Color primaryColor = Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Lista de Compras',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network('lib/imgs/lista_compras.png', height: 250, width: 250,),
            const SizedBox(height: 50),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: const TextStyle(color: primaryColor),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
                ),
              ),
              style: const TextStyle(fontSize: 18, color: primaryColor),
              onChanged: (value) {
                nome = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(color: primaryColor),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
                ),
              ),
              style: const TextStyle(fontSize: 18, color: primaryColor),
              obscureText: true,
              onChanged: (value) {
                senha = value;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (nome.isNotEmpty && senha.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(nome: nome),
                    ),
                  );
                } else {
                  _loginUsuario(context);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // torna o botão quadrado
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 50), // aumenta o tamanho do botão
                textStyle:
                    const TextStyle(fontSize: 20), // aumenta o tamanho da fonte
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Cor do texto
              ),
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // torna o botão quadrado
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 50), // aumenta o tamanho do botão
                textStyle:
                    const TextStyle(fontSize: 20), // aumenta o tamanho da fonte
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Cor do texto
              ),
              child: const Text('Criar uma conta'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUsuario(BuildContext context) {
    const snackBar =
        SnackBar(content: Text('Por favor, preencha todos os campos'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
