import 'package:flutter/widgets.dart';

class Escuta<T extends Listenable> extends StatefulWidget {
  const Escuta({
    super.key,
    required this.observavel,
    required this.builder,
  });

  final T observavel;
  final Widget Function(BuildContext context, T observavel) builder;

  @override
  State<Escuta<T>> createState() => _EscutaState<T>();
}

class _EscutaState<T extends Listenable> extends State<Escuta<T>> {
  @override
  void initState() {
    super.initState();
    widget.observavel.addListener(_atualizar);
  }

  @override
  void didUpdateWidget(Escuta<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.observavel != widget.observavel) {
      oldWidget.observavel.removeListener(_atualizar);
      widget.observavel.addListener(_atualizar);
    }
  }

  @override
  void dispose() {
    widget.observavel.removeListener(_atualizar);
    super.dispose();
  }

  void _atualizar() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.observavel);
  }
}
