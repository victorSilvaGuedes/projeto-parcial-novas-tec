import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _cadastrarUsuario() {
    String nome = _nomeController.text.trim();
    String email = _emailController.text.trim();
    String senha = _senhaController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      _showSnackBar('Por favor, preencha todos os campos');
    } else {
      _showSnackBar('Cadastro realizado com sucesso!');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network('lib/imgs/cadastro_usuario.png', height: 200),
          const SizedBox(height: 40),
          TextFormField(
            controller: _nomeController,
            decoration: InputDecoration(
              labelText: 'Nome',
              labelStyle: const TextStyle(color: Colors.blue),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
              ),
            ),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(color: Colors.blue),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
              ),
            ),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _senhaController,
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: const TextStyle(color: Colors.blue),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
              ),
            ),
            obscureText: true,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _cadastrarUsuario,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 50),
                textStyle:
                    const TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}
