import 'package:flutter/foundation.dart';

import '../core/validador.dart';
import '../models/usuario.dart';

class AutenticacaoController extends ChangeNotifier {
  static const emailDemonstracao = 'cliente@loja.com';
  static const senhaDemonstracao = '123456';

  AutenticacaoController() {
    _usuarios.add(
      const Usuario(
        nome: 'Ana Ribeiro',
        email: emailDemonstracao,
        senha: senhaDemonstracao,
      ),
    );
  }

  final List<Usuario> _usuarios = [];
  Usuario? _usuarioAtual;

  bool get autenticado => _usuarioAtual != null;

  Usuario? get usuarioAtual => _usuarioAtual;

  String get primeiroNome {
    final nome = _usuarioAtual?.nome.trim() ?? '';
    if (nome.isEmpty) return '';
    return nome.split(RegExp(r'\s+')).first;
  }

  String? entrar(String email, String senha) {
    final normalizado = email.trim().toLowerCase();
    if (!Validador.emailValido(normalizado) || senha.isEmpty) {
      return 'E-mail ou senha incorretos.';
    }

    for (final usuario in _usuarios) {
      if (usuario.email == normalizado && usuario.senha == senha) {
        _usuarioAtual = usuario;
        notifyListeners();
        return null;
      }
    }

    return 'E-mail ou senha incorretos.';
  }

  String? cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) {
    final nomeLimpo = nome.trim();
    final emailLimpo = email.trim().toLowerCase();
    final erroNome = Validador.nome(nomeLimpo);
    final erroEmail = Validador.email(emailLimpo);
    final erroSenha = Validador.senha(senha);

    if (erroNome != null) return erroNome;
    if (erroEmail != null) return erroEmail;
    if (erroSenha != null) return erroSenha;

    final existente = _usuarios.any((usuario) => usuario.email == emailLimpo);
    if (existente) return 'Já existe uma conta com este e-mail.';

    final usuario = Usuario(nome: nomeLimpo, email: emailLimpo, senha: senha);
    _usuarios.add(usuario);
    _usuarioAtual = usuario;
    notifyListeners();
    return null;
  }

  void sair() {
    _usuarioAtual = null;
    notifyListeners();
  }
}
