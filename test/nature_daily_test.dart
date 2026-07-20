import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nature_daily/nature_daily.dart';

void main() {
  group('Ecossistema', () {
    test('cria instância e converte para/de Map corretamente', () {
      const item = Ecossistema(
        id: 'teste_01',
        assetPath: 'assets/images/teste.webp',
        titulo: 'Teste',
        descricao: 'Descrição de teste',
        categoria: 'Categoria Teste',
      );

      final map = item.toMap();
      final reconstruido = Ecossistema.fromMap(map);

      expect(reconstruido, equals(item));
      expect(reconstruido.id, 'teste_01');
    });

    test('dois itens com mesmo id são considerados iguais', () {
      const a = Ecossistema(
        id: 'x',
        assetPath: 'a.webp',
        titulo: 'A',
        descricao: 'a',
        categoria: 'cat',
      );
      const b = Ecossistema(
        id: 'x',
        assetPath: 'b.webp',
        titulo: 'B',
        descricao: 'b',
        categoria: 'outra',
      );

      expect(a, equals(b));
    });
  });

  group('NatureDailyEngine', () {
    late List<Ecossistema> lista;
    late NatureDailyEngine engine;

    setUp(() {
      lista = List.generate(
        10,
        (i) => Ecossistema(
          id: 'item_$i',
          assetPath: 'assets/images/item_$i.webp',
          titulo: 'Item $i',
          descricao: 'Descrição $i',
          categoria: 'Categoria ${i % 3}',
        ),
      );
      engine = NatureDailyEngine(lista);
    });

    test('inicia no index 0', () {
      expect(engine.currentIndex, 0);
      expect(engine.currentItem.id, 'item_0');
    });

    test('next() avança sequencialmente', () {
      engine.next();
      expect(engine.currentIndex, 1);
      engine.next();
      expect(engine.currentIndex, 2);
    });

    test('next() reinicia para 0 ao ultrapassar o último item', () {
      // Avança até o último index (length - 1)
      for (var i = 0; i < lista.length - 1; i++) {
        engine.next();
      }
      expect(engine.currentIndex, lista.length - 1);

      // Mais um next() deve dar a volta para o index 0
      final item = engine.next();
      expect(engine.currentIndex, 0);
      expect(item.id, 'item_0');
    });

    test('getBySeed é determinístico para a mesma seed', () {
      final a = engine.getBySeed(42);
      final b = engine.getBySeed(42);
      expect(a, equals(b));
    });

    test('getBySeed aplica módulo corretamente (cíclico)', () {
      final itemSeed0 = engine.getBySeed(0);
      final itemSeedLength = engine.getBySeed(lista.length);
      expect(itemSeed0, equals(itemSeedLength));
    });

    test('getBySeed lida com seeds negativas sem lançar erro', () {
      expect(() => engine.getBySeed(-5), returnsNormally);
    });

    test('getByDate retorna o mesmo item para a mesma data', () {
      final data = DateTime(2026, 3, 15);
      final a = engine.getByDate(data);
      final b = engine.getByDate(data);
      expect(a, equals(b));
    });

    test('reset() volta o cursor para o index 0', () {
      engine.next();
      engine.next();
      engine.reset();
      expect(engine.currentIndex, 0);
    });
  });

  group('ecossistemasData', () {
    test('não está vazia e todos os itens têm id único', () {
      expect(ecossistemasData, isNotEmpty);
      final ids = ecossistemasData.map((e) => e.id).toSet();
      expect(ids.length, ecossistemasData.length);
    });
  });

  group('carregarEcossistemasDosAssets (descoberta automática)', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    test('encontra ao menos 1 imagem .webp real em assets/images/', () async {
      final lista = await carregarEcossistemasDosAssets();

      expect(
        lista,
        isNotEmpty,
        reason:
            'Nenhum .webp encontrado em assets/images/. Confirme que o '
            'pubspec.yaml declara "assets/images/" e que existe ao menos '
            'um arquivo .webp real dentro dessa pasta no repositório.',
      );

      for (final item in lista) {
        expect(
          File(item.assetPath).existsSync(),
          isTrue,
          reason: 'Caminho gerado não bate com um arquivo real: '
              '${item.assetPath}',
        );
      }
    });

    test('funciona corretamente dentro do NatureDailyEngine', () async {
      final lista = await carregarEcossistemasDosAssets();
      final engine = NatureDailyEngine(lista);

      expect(engine.totalItens, lista.length);
      expect(engine.getConteudoDeHoje(), isA<Ecossistema>());
    });
  });
}
