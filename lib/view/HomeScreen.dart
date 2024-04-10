import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/ShoppingList.dart';

import 'AboutTheProject.dart';

class HomeScreen extends StatelessWidget {
  final String nome;

  const HomeScreen({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $nome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('lib/imgs/lista-home.png', height: 200),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingListApp(),
                  ),
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
              child: const Text('Criar lista de compras'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutTheProject(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // torna o botão quadrado
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 64), // aumenta o tamanho do botão
                textStyle:
                    const TextStyle(fontSize: 20), // aumenta o tamanho da fonte
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Cor do texto
              ),
              child: const Text('Ver sobre o projeto'),
            ),
          ],
        ),
      ),
    );
  }
}
