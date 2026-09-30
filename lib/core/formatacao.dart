String formatarMoeda(double valor) {
  final centavos = (valor.abs() * 100).round();
  final inteiro = centavos ~/ 100;
  final fracao = (centavos % 100).toString().padLeft(2, '0');
  final digitos = inteiro.toString();
  final buffer = StringBuffer();

  for (var indice = 0; indice < digitos.length; indice++) {
    if (indice > 0 && (digitos.length - indice) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digitos[indice]);
  }

  final sinal = valor < 0 ? '-' : '';
  return 'R\$ $sinal$buffer,$fracao';
}
