import '../../domain/entities/anuncio.dart';

/// A classe AnuncioModel é uma representação de dados de um anúncio.
/// Esta classe é usada para transferir dados de e para APIs ou outras
/// fontes de dados, e pode ser convertida para a entidade Anuncio
/// do domínio do aplicativo.

class AnuncioModel extends Anuncio {
  /// Construtor da classe AnuncioModel.
  ///
  /// Chama o construtor da classe base Anuncio.
  AnuncioModel({
    required super.id,
    required super.tipo,
    super.carregado,
    super.exibido,
  });

  /// Cria uma instância de AnuncioModel a partir de um mapa JSON.
  ///
  /// [json] é o mapa JSON contendo os dados do anúncio.
  /// Retorna uma nova instância de AnuncioModel.
  factory AnuncioModel.fromJson(Map<String, dynamic> json) {
    return AnuncioModel(
      id: json['id'] as String,
      tipo: json['tipo'] as String,
      carregado: json['carregado'] as bool? ?? false,
      exibido: json['exibido'] as bool? ?? false,
    );
  }

  /// Converte a instância de AnuncioModel para um mapa JSON.
  ///
  /// Retorna um mapa JSON representando os dados do anúncio.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'carregado': carregado,
      'exibido': exibido,
    };
  }
}
