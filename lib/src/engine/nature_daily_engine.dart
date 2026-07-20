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

  NatureDailyEngine(List<Ecossistema> ecossistemas, {int startIndex = 0})
      : assert(
          ecossistemas.isNotEmpty,
          'A lista de ecossistemas não pode ser vazia',
        ),
        _ecossistemas = List.unmodifiable(ecossistemas),
        _currentIndex = startIndex % ecossistemas.length;

  int get totalItens => _ecossistemas.length;

  int get currentIndex => _currentIndex;

  Ecossistema get currentItem => _ecossistemas[_currentIndex];

  List<Ecossistema> get todos => _ecossistemas;

  Ecossistema next() {
    _currentIndex = (_currentIndex + 1) % _ecossistemas.length;
    return currentItem;
  }

  Ecossistema previous() {
    _currentIndex =
        (_currentIndex - 1 + _ecossistemas.length) % _ecossistemas.length;
    return currentItem;
  }

  Ecossistema getBySeed(int seed) {
    final length = _ecossistemas.length;
    final index = ((seed % length) + length) % length;
    return _ecossistemas[index];
  }

  Ecossistema getByDate(DateTime data) {
    final diaDoAno = _diaDoAno(data);
    return getBySeed(diaDoAno);
  }

  Ecossistema getConteudoDeHoje() => getByDate(DateTime.now());

  void reset() {
    _currentIndex = 0;
  }

  int _diaDoAno(DateTime data) {
    final inicioDoAno = DateTime(data.year, 1, 1);
    return data.difference(inicioDoAno).inDays;
  }
}
