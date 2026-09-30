import 'package:flutter/material.dart';

import '../controllers/autenticacao_controller.dart';
import '../core/escopo.dart';
import '../core/navegacao.dart';
import '../core/validador.dart';
import 'componentes/cabecalho_acesso.dart';
import 'componentes/campo_senha.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  String? _mensagem;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _limparMensagem(String _) {
    if (_mensagem != null) setState(() => _mensagem = null);
  }

  void _entrar() {
    final formulario = _formKey.currentState;
    if (formulario == null || !formulario.validate()) return;

    final erro = AppEscopo.of(context).autenticacao.entrar(
      _emailController.text,
      _senhaController.text,
    );

    if (erro != null) {
      setState(() => _mensagem = erro);
      return;
    }

    Navegacao.entrarNaLoja(context);
  }

  void _usarDemonstracao() {
    _emailController.text = AutenticacaoController.emailDemonstracao;
    _senhaController.text = AutenticacaoController.senhaDemonstracao;
    setState(() => _mensagem = null);
    _entrar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CabecalhoAcesso(
              titulo: 'Entrar na loja',
              subtitulo: 'Acesse o catálogo, monte o carrinho e feche o pedido nesta sessão.',
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
                      onChanged: _limparMensagem,
                      onFieldSubmitted: (_) => _entrar(),
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
                      onPressed: _entrar,
                      child: const Text('Entrar'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: _usarDemonstracao,
                      child: const Text('Usar conta de demonstração'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AutenticacaoController.emailDemonstracao} · senha ${AutenticacaoController.senhaDemonstracao}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Ainda não tem conta?'),
                        TextButton(
                          onPressed: () => Navegacao.abrirCadastro(context),
                          child: const Text('Criar cadastro'),
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
