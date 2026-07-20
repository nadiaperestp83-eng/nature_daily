import '../models/ecossistema.dart';

/// Motor responsável por selecionar o conteúdo de [Ecossistema] de forma
/// cíclica e determinística, 100% offline (sem rede, sem Gradle, sem
/// dependências externas).
///
/// Regras principais:
/// - A lista é percorrida em ciclo: ao chegar ao último item (index
///   `length - 1`), o próximo acesso reinicia automaticamente em index 0.
/// - Dado o mesmo `seed` (ex: dia do ano), o motor sempre retorna o mesmo
///   item — determinismo garantido por operação de módulo (`%`).
class NatureDailyEngine {
  final List<Ecossistema> _ecossistemas;
  int _currentIndex;

  /// [ecossistemas] deve conter ao menos 1 item. O motor funciona com
  /// qualquer tamanho de lista (não precisa ser exatamente 100), mas o
  /// caso de uso alvo é uma lista de 100 itens (index 0 a 99).
  NatureDailyEngine(List<Ecossistema> ecossistemas, {int startIndex = 0})
      : assert(
          ecossistemas.isNotEmpty,
          'A lista de ecossistemas não pode ser vazia',
        ),
        _ecossistemas = List.unmodifiable(ecossistemas),
        _currentIndex = startIndex % ecossistemas.length;

  /// Total de itens carregados no motor.
  int get totalItens => _ecossistemas.length;

  /// Índice atual do "cursor" interno do motor.
  int get currentIndex => _currentIndex;

  /// Item correspondente ao [currentIndex] atual.
  Ecossistema get currentItem => _ecossistemas[_currentIndex];

  /// Lista completa e imutável carregada no motor.
  List<Ecossistema> get todos => _ecossistemas;

  /// Avança o cursor interno em 1 posição de forma cíclica.
  ///
  /// Quando o índice ultrapassa o último item da lista (ex: item 100,
  /// index 99), reinicia automaticamente para o index 0.
  Ecossistema next() {
    _currentIndex = (_currentIndex + 1) % _ecossistemas.length;
    return currentItem;
  }

  /// Retrocede o cursor interno em 1 posição de forma cíclica.
  Ecossistema previous() {
    _currentIndex =
        (_currentIndex - 1 + _ecossistemas.length) % _ecossistemas.length;
    return currentItem;
  }

  /// Retorna o [Ecossistema] correspondente a uma [seed] arbitrária
  /// (ex: número do dia do ano, timestamp, ID de usuário, etc).
  ///
  /// A seleção é determinística: a mesma seed sempre retorna o mesmo item,
  /// e o índice é sempre normalizado ciclicamente via módulo.
  Ecossistema getBySeed(int seed) {
    final length = _ecossistemas.length;
    final index = ((seed % length) + length) % length; // normaliza negativos
    return _ecossistemas[index];
  }

  /// Retorna o conteúdo do dia com base na [data] informada, usando o
  /// "dia do ano" (1 a 365/366) como seed. Determinístico: a mesma data
  /// sempre retorna o mesmo conteúdo.
  Ecossistema getByDate(DateTime data) {
    final diaDoAno = _diaDoAno(data);
    return getBySeed(diaDoAno);
  }

  /// Atalho para [getByDate] usando a data atual do dispositivo.
  Ecossistema getConteudoDeHoje() => getByDate(DateTime.now());

  /// Reinicia o cursor interno do motor para o index 0.
  void reset() {
    _currentIndex = 0;
  }

  int _diaDoAno(DateTime data) {
    final inicioDoAno = DateTime(data.year, 1, 1);
    return data.difference(inicioDoAno).inDays; // 0-based, já serve como seed
  }
}
