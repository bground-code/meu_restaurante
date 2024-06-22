import 'package:flutter/material.dart';
import 'package:quero_comer/commom/my_snackbar.dart';
import 'package:quero_comer/service/authentication_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoginMode = true;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final AuthenticationService _authService = AuthenticationService();

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  void _login() {
    String senha = _senhaController.text;
    String email = _emailController.text;
    if (email.isEmpty || senha.isEmpty) {
      showSnackBar(
          context: context, text: "Por favor, preencha todos os campos.");
    } else {
      if (_isLoginMode) {
        _authService.loginUser(email: email, senha: senha).then((value) => {
              if (value != null)
                {showSnackBar(context: context, text: value)}
              else
                {Navigator.pushReplacementNamed(context, '/home')}
            });
      } else {
        showSnackBar(context: context, text: "E-mail ou senha inválidos.");
      }
    }
  }

  void _register() {
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    String email = _emailController.text;

    if (nome.isEmpty || senha.isEmpty || email.isEmpty) {
      showSnackBar(
          context: context, text: "Por favor, preencha todos os campos.");
    } else {
      _authService
          .registerUser(nome: nome, senha: senha, email: email)
          .then((value) => {
                if (value != null) {showSnackBar(context: context, text: value)}
              });
      //Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logoj.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                _isLoginMode ? _buildLoginForm() : _buildRegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStyledTextField('Email', controller: _emailController),
        const SizedBox(height: 20),
        _buildStyledTextField('Senha',
            controller: _senhaController, obscureText: true),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: const Text('Entrar'),
        ),
        TextButton(
          onPressed: _toggleMode,
          child: const Text('Já tem uma conta? Entre!'),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStyledTextField('Nome', controller: _nomeController),
        const SizedBox(height: 20),
        _buildStyledTextField('Email', controller: _emailController),
        const SizedBox(height: 20),
        _buildStyledTextField('Senha',
            controller: _senhaController, obscureText: true),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _register,
          child: const Text('Cadastrar'),
        ),
        TextButton(
          onPressed: _toggleMode,
          child: const Text('Já tem uma conta? Entre!'),
        ),
      ],
    );
  }

  Widget _buildStyledTextField(String label,
      {bool obscureText = false, TextEditingController? controller}) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        maxLength: 50,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintText: label,
          counterText: "", // Remove o texto do contador abaixo do TextField
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
