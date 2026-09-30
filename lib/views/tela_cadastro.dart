import 'package:flutter/material.dart';

import '../core/escopo.dart';
import '../core/navegacao.dart';
import '../core/validador.dart';
import 'componentes/cabecalho_acesso.dart';
import 'componentes/campo_senha.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarController = TextEditingController();
  String? _mensagem;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  void _limparMensagem(String _) {
    if (_mensagem != null) setState(() => _mensagem = null);
  }

  void _cadastrar() {
    final formulario = _formKey.currentState;
    if (formulario == null || !formulario.validate()) return;

    final erro = AppEscopo.of(context).autenticacao.cadastrar(
      nome: _nomeController.text,
      email: _emailController.text,
      senha: _senhaController.text,
    );

    if (erro != null) {
      setState(() => _mensagem = erro);
      return;
    }

    Navegacao.entrarNaLoja(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CabecalhoAcesso(
              titulo: 'Criar conta',
              subtitulo: 'O cadastro fica só nesta sessão. Nada é gravado em banco de dados.',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.name],
                      onChanged: _limparMensagem,
                      validator: Validador.nome,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      autocorrect: false,
                      onChanged: _limparMensagem,
                      validator: Validador.email,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: 14),
                    CampoSenha(
                      controller: _senhaController,
                      rotulo: 'Senha',
                      validador: Validador.senha,
                      textInputAction: TextInputAction.next,
                      onChanged: _limparMensagem,
                    ),
                    const SizedBox(height: 14),
                    CampoSenha(
                      controller: _confirmarController,
                      rotulo: 'Confirmar senha',
                      validador: (valor) => Validador.confirmarSenha(valor, _senhaController.text),
                      onChanged: _limparMensagem,
                      onFieldSubmitted: (_) => _cadastrar(),
                    ),
                    if (_mensagem != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _mensagem!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                    const SizedBox(height: 22),
                    FilledButton(
                      onPressed: _cadastrar,
                      child: const Text('Cadastrar'),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Já tem conta?'),
                        TextButton(
                          onPressed: () => Navegacao.voltarAoLogin(context),
                          child: const Text('Entrar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
