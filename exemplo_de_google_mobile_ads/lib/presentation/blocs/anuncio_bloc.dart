// presentation/blocs/anuncio_bloc.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/carregar_anuncio.dart';

/// Eventos para o AnuncioBloc, que representam ações
/// que podem ser realizadas no bloco.
abstract class AnuncioEvent extends Equatable {
  const AnuncioEvent();

  @override
  List<Object> get props => [];
}

/// Evento para carregar um anúncio de um tipo específico.
class CarregarAnuncioEvent extends AnuncioEvent {
  final String tipo;

  const CarregarAnuncioEvent(this.tipo);

  @override
  List<Object> get props => [tipo];
}

/// Estados para o AnuncioBloc, que representam o
/// estado atual do bloco.
abstract class AnuncioState extends Equatable {
  const AnuncioState();

  @override
  List<Object> get props => [];
}

/// Estado inicial do AnuncioBloc.
class AnuncioInitial extends AnuncioState {}

/// Estado indicando que um anúncio está sendo carregado.
class AnuncioLoading extends AnuncioState {}

/// Estado indicando que um anúncio foi carregado com sucesso.
class AnuncioCarregado extends AnuncioState {
  final Anuncio anuncio;

  const AnuncioCarregado(this.anuncio);

  @override
  List<Object> get props => [anuncio];
}

/// Estado indicando que houve um erro ao carregar um anúncio.
class AnuncioErro extends AnuncioState {
  final String mensagem;

  const AnuncioErro(this.mensagem);

  @override
  List<Object> get props => [mensagem];
}

/// O AnuncioBloc gerencia o estado dos anúncios, respondendo
/// a eventos e emitindo novos estados.
class AnuncioBloc extends Bloc<AnuncioEvent, AnuncioState> {
  final CarregarAnuncio carregarAnuncio;

  AnuncioBloc({required this.carregarAnuncio}) : super(AnuncioInitial()) {
    on<CarregarAnuncioEvent>(_onCarregarAnuncio);
  }

  /// Manipula o evento de carregamento de anúncio, utilizando
  /// o caso de uso CarregarAnuncio para realizar a lógica de negócios.
  Future<void> _onCarregarAnuncio(
      CarregarAnuncioEvent event, Emitter<AnuncioState> emit) async {
    emit(AnuncioLoading());
    try {
      final anuncio = await carregarAnuncio.execute(event.tipo);
      emit(AnuncioCarregado(anuncio));
    } catch (e) {
      emit(AnuncioErro('Erro ao carregar anúncio: $e'));
    }
  }
}
