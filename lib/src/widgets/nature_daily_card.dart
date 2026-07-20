import 'package:flutter/material.dart';

import '../engine/nature_daily_engine.dart';
import '../models/ecossistema.dart';

/// Card pronto para exibir o conteúdo educativo do dia (imagem + título +
/// descrição + categoria), consumindo o [NatureDailyEngine].
///
/// Uso básico:
/// ```dart
/// final engine = NatureDailyEngine(ecossistemasData);
///
/// NatureDailyCard(
///   engine: engine,
///   onProximo: () => setState(() {}), // rebuild após engine.next()
/// )
/// ```
class NatureDailyCard extends StatelessWidget {
  /// Motor já inicializado com a lista de [Ecossistema].
  final NatureDailyEngine engine;

  /// Se true, mostra o conteúdo do dia atual (baseado na data).
  /// Se false, mostra o item apontado pelo cursor interno do engine
  /// ([NatureDailyEngine.currentItem]).
  final bool usarConteudoDeHoje;

  /// Callback opcional exibido como botão "Próximo", útil quando
  /// [usarConteudoDeHoje] é false e você quer navegar manualmente pelo
  /// motor (chame `engine.next()` dentro do callback e depois rebuild).
  final VoidCallback? onProximo;

  const NatureDailyCard({
    super.key,
    required this.engine,
    this.usarConteudoDeHoje = true,
    this.onProximo,
  });

  Ecossistema get _item =>
      usarConteudoDeHoje ? engine.getConteudoDeHoje() : engine.currentItem;

  @override
  Widget build(BuildContext context) {
    final item = _item;
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              item.assetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 40,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.titulo,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(item.categoria),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              item.descricao,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          if (onProximo != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onProximo,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Próximo'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
