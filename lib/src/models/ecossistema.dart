import 'package:flutter/foundation.dart';

/// Representa um item de conteúdo educativo sobre um ecossistema natural.
///
/// Cada [Ecossistema] é totalmente offline: [assetPath] aponta para uma
/// imagem local (.webp) empacotada dentro de `assets/images/` do pacote.
@immutable
class Ecossistema {
  /// Identificador único e estável do item (ex: 'floresta_amazonica_01').
  final String id;

  /// Caminho do asset local, ex: 'assets/images/floresta_amazonica.webp'.
  final String assetPath;

  /// Título curto exibido para o usuário.
  final String titulo;

  /// Texto educativo/descritivo sobre o ecossistema.
  final String descricao;

  /// Categoria/agrupamento (ex: 'Floresta', 'Oceano', 'Deserto', 'Savana').
  final String categoria;

  const Ecossistema({
    required this.id,
    required this.assetPath,
    required this.titulo,
    required this.descricao,
    required this.categoria,
  })  : assert(id != '', 'id não pode ser vazio'),
        assert(assetPath != '', 'assetPath não pode ser vazio');

  factory Ecossistema.fromMap(Map<String, dynamic> map) {
    return Ecossistema(
      id: map['id'] as String,
      assetPath: map['assetPath'] as String,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      categoria: map['categoria'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assetPath': assetPath,
      'titulo': titulo,
      'descricao': descricao,
      'categoria': categoria,
    };
  }

  Ecossistema copyWith({
    String? id,
    String? assetPath,
    String? titulo,
    String? descricao,
    String? categoria,
  }) {
    return Ecossistema(
      id: id ?? this.id,
      assetPath: assetPath ?? this.assetPath,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      categoria: categoria ?? this.categoria,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ecossistema &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Ecossistema(id: $id, titulo: $titulo, categoria: $categoria, '
      'assetPath: $assetPath)';
}
