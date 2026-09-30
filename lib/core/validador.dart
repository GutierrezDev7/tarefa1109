class Validador {
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static bool emailValido(String email) => _email.hasMatch(email.trim());

  static String? nome(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe o nome';
    if (texto.length < 3) return 'Use pelo menos 3 letras';
    return null;
  }

  static String? email(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe o e-mail';
    if (!emailValido(texto)) return 'E-mail inválido';
    return null;
  }

  static String? senha(String? valor) {
    final texto = valor ?? '';
    if (texto.isEmpty) return 'Informe a senha';
    if (texto.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  static String? confirmarSenha(String? valor, String senha) {
    if (valor == null || valor.isEmpty) return 'Confirme a senha';
    if (valor != senha) return 'As senhas não coincidem';
    return null;
  }
}
