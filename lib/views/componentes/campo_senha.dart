import 'package:flutter/material.dart';

class CampoSenha extends StatefulWidget {
  const CampoSenha({
    super.key,
    required this.controller,
    required this.rotulo,
    this.validador,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final TextEditingController controller;
  final String rotulo;
  final String? Function(String?)? validador;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  @override
  State<CampoSenha> createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<CampoSenha> {
  var _oculta = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _oculta,
      validator: widget.validador,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        labelText: widget.rotulo,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          tooltip: _oculta ? 'Mostrar senha' : 'Ocultar senha',
          onPressed: () => setState(() => _oculta = !_oculta),
          icon: Icon(_oculta ? Icons.visibility_outlined : Icons.visibility_off_outlined),
        ),
      ),
    );
  }
}
