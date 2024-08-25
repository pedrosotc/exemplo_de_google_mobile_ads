class Anuncio {
  /// A classe Anuncio representa um anúncio publicitário dentro do
  /// domínio do aplicativo. Esta entidade encapsula as informações
  /// necessárias para gerenciar e exibir anúncios de diferentes tipos.

  /// Identificador único do anúncio. Pode ser usado para
  /// diferenciar entre diferentes instâncias de anúncios.
  final String id;

  /// Tipo de anúncio (ex.: 'banner', 'intersticial', 'recompensado').
  final String tipo;

  /// Indica se o anúncio está carregado e pronto para ser exibido.
  final bool carregado;

  /// Indica se o anúncio foi exibido para o usuário.
  final bool exibido;

  /// Construtor da classe Anuncio.
  ///
  /// [id] é o identificador único do anúncio.
  /// [tipo] define o tipo do anúncio.
  /// [carregado] indica o estado de carregamento do anúncio.
  /// [exibido] indica se o anúncio já foi exibido.
  Anuncio({
    required this.id,
    required this.tipo,
    this.carregado = false,
    this.exibido = false,
  });

  /// Retorna uma representação textual do anúncio.
  ///
  /// Útil para fins de depuração e logging.
  @override
  String toString() {
    return 'Anuncio{id: $id, tipo: $tipo, carregado: $carregado, exibido: $exibido}';
  }

  /// Método de fábrica para criar um novo Anuncio como uma cópia
  /// do existente, mas com algumas propriedades alteradas.
  ///
  /// [carregado] e [exibido] podem ser alterados ao criar a cópia.
  Anuncio copyWith({
    bool? carregado,
    bool? exibido,
  }) {
    return Anuncio(
      id: id,
      tipo: tipo,
      carregado: carregado ?? this.carregado,
      exibido: exibido ?? this.exibido,
    );
  }
}
