import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> registerUser(
      {required String nome,
      required String senha,
      required String email}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);
      await credential.user!.updateDisplayName(nome);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O e-mail já está em uso.";
      }
      if (e.code == 'weak-password') {
        return "A senha fornecida é muito fraca.";
      }
      if (e.code == 'invalid-email') {
        return "e-mail inválido.";
      }
      return "Erro Desconhecido";
    }
  }

  Future<String?> loginUser(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'the email address is baddly formatted') {
        return "O endereço de e-mail está mal formatado";
      }
      return "Email ou senha inválidos";
    }
  }

  Future<void> exit() async {
    try {
      print("Iniciando logout...");
      await _firebaseAuth.signOut();
      print("Logout bem-sucedido. Redirecionando para a página de login...");
    } catch (e) {
      print("Erro ao fazer logout: $e");
    }
  }
}
