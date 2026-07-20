import '../models/ecossistema.dart';

/// Dataset de exemplo com 10 itens reais. Para atingir os 100 itens do
/// motor cíclico, basta seguir o mesmo padrão abaixo, adicionando novas
/// instâncias de [Ecossistema] e os respectivos arquivos .webp em
/// `assets/images/`.
///
/// O [NatureDailyEngine] funciona com qualquer tamanho de lista, então o
/// app pode ser testado com estes 10 itens antes de completar os 100.
const List<Ecossistema> ecossistemasData = [
  Ecossistema(
    id: 'floresta_amazonica',
    assetPath: 'assets/images/floresta_amazonica.webp',
    titulo: 'Floresta Amazônica',
    descricao: 'A maior floresta tropical do mundo, abrigando cerca de 10% de toda a biodiversidade conhecida do planeta.',
    categoria: 'Floresta',
  ),
  Ecossistema(
    id: 'recife_de_coral',
    assetPath: 'assets/images/recife_de_coral.webp',
    titulo: 'Recife de Coral',
    descricao: 'Ecossistemas marinhos formados por colônias de corais, essenciais para a vida de milhares de espécies aquáticas.',
    categoria: 'Oceano',
  ),
  Ecossistema(
    id: 'deserto_do_saara',
    assetPath: 'assets/images/deserto_do_saara.webp',
    titulo: 'Deserto do Saara',
    descricao: 'O maior deserto quente do mundo, com adaptações extremas de fauna e flora à escassez de água.',
    categoria: 'Deserto',
  ),
  Ecossistema(
    id: 'savana_africana',
    assetPath: 'assets/images/savana_africana.webp',
    titulo: 'Savana Africana',
    descricao: 'Vastas planícies com vegetação rasteira e árvores esparsas, lar de grandes mamíferos migratórios.',
    categoria: 'Savana',
  ),
  Ecossistema(
    id: 'tundra_artica',
    assetPath: 'assets/images/tundra_artica.webp',
    titulo: 'Tundra Ártica',
    descricao: 'Bioma frio e de baixa vegetação, com solo permanentemente congelado chamado permafrost.',
    categoria: 'Tundra',
  ),
  Ecossistema(
    id: 'manguezal',
    assetPath: 'assets/images/manguezal.webp',
    titulo: 'Manguezal',
    descricao: 'Ecossistema costeiro de transição entre ambientes terrestres e marinhos, berçário de diversas espécies.',
    categoria: 'Costeiro',
  ),
  Ecossistema(
    id: 'pantanal',
    assetPath: 'assets/images/pantanal.webp',
    titulo: 'Pantanal',
    descricao: 'Maior planície alagável do mundo, com ciclos sazonais de cheia e seca que moldam sua rica biodiversidade.',
    categoria: 'Área Úmida',
  ),
  Ecossistema(
    id: 'floresta_boreal',
    assetPath: 'assets/images/floresta_boreal.webp',
    titulo: 'Floresta Boreal (Taiga)',
    descricao: 'O maior bioma terrestre do mundo, dominado por coníferas e adaptado a invernos longos e rigorosos.',
    categoria: 'Floresta',
  ),
  Ecossistema(
    id: 'oceano_profundo',
    assetPath: 'assets/images/oceano_profundo.webp',
    titulo: 'Oceano Profundo',
    descricao: 'Ambiente sem luz solar direta, com espécies adaptadas a altíssima pressão e escuridão quase total.',
    categoria: 'Oceano',
  ),
  Ecossistema(
    id: 'cerrado',
    assetPath: 'assets/images/cerrado.webp',
    titulo: 'Cerrado',
    descricao: 'Savana tropical brasileira, considerada a savana mais biodiversa do mundo, com solo ácido e vegetação retorcida.',
    categoria: 'Savana',
  ),
];
