import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/ecossistema.dart';

/// Descobre automaticamente, em tempo de execução, todos os arquivos
/// `.webp` presentes em [pastaAssets] (declarada no `pubspec.yaml`) e
/// gera uma lista de [Ecossistema] a partir deles — sem precisar
/// cadastrar nome de arquivo nenhum manualmente no código.
///
/// Isso resolve o problema de manter `ecossistemas_data.dart` sincronizado
/// com os nomes reais dos arquivos: basta colocar o `.webp` dentro de
/// `assets/images/` que ele já aparece automaticamente na próxima vez
/// que o app carregar.
///
/// [metadados] é opcional: permite sobrescrever título/descrição/categoria
/// de um arquivo específico usando o nome do arquivo (sem extensão) como
/// chave. Qualquer arquivo sem entrada em [metadados] recebe título e
/// categoria gerados a partir do próprio nome do arquivo.
Future<List<Ecossistema>> carregarEcossistemasDosAssets({
  String pastaAssets = 'assets/images/',
  Map<String, EcossistemaMetadado>? metadados,
}) async {
  final manifestJson = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifest =
      jsonDecode(manifestJson) as Map<String, dynamic>;

  final caminhosWebp = manifest.keys
      .where((path) => path.startsWith(pastaAssets) && path.endsWith('.webp'))
      .toList()
    ..sort();

  return caminhosWebp.map((caminho) {
    final nomeArquivo = caminho.split('/').last.replaceAll('.webp', '');
    final meta = metadados?[nomeArquivo];

    return Ecossistema(
      id: nomeArquivo,
      assetPath: caminho,
      titulo: meta?.titulo ?? _tituloAPartirDoNome(nomeArquivo),
      descricao: meta?.descricao ?? 'Conteúdo educativo sobre $nomeArquivo.',
      categoria: meta?.categoria ?? 'Natureza',
    );
  }).toList();
}

/// Metadados opcionais para sobrescrever um item gerado automaticamente
/// por [carregarEcossistemasDosAssets].
class EcossistemaMetadado {
  final String? titulo;
  final String? descricao;
  final String? categoria;

  const EcossistemaMetadado({this.titulo, this.descricao, this.categoria});
}

String _tituloAPartirDoNome(String nomeArquivo) {
  final semSeparadores = nomeArquivo.replaceAll(RegExp(r'[-_]+'), ' ').trim();
  if (semSeparadores.isEmpty) return nomeArquivo;
  return semSeparadores
      .split(' ')
      .map((palavra) => palavra.isEmpty
          ? palavra
          : palavra[0].toUpperCase() + palavra.substring(1))
      .join(' ');
}
