import 'package:flutter/material.dart';

class AboutTheProject extends StatelessWidget {
  const AboutTheProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do projeto'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'lib/imgs/flutter.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 40),
              const Text(
                'Esse projeto foi feito para colocar em prática todo o conhecimento adquirido durante as aulas de:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Novas Tecnologias de Informação e Comunicação',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'O tema do projeto é um app para criar listas de compras',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Toda a tecnologia utilizada no projeto foi a Flutter SDK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Feito por:\nVictor Silva Guedes - 836450',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
