import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/anuncio_bloc.dart';
import '../widgets/banner_widget.dart';
import '../widgets/intersticial_widget.dart';
import '../widgets/recompensado_widget.dart';

/// A HomePage é a interface principal do aplicativo, onde os
/// anúncios são exibidos. Integra widgets de anúncios e utiliza
/// o AnuncioBloc para gerenciar o estado dos anúncios.

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Instâncias dos widgets de anúncios.
  final IntersticialWidget intersticialWidget = IntersticialWidget();
  final RecompensadoWidget recompensadoWidget = RecompensadoWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anúncios App'),
      ),
      body: BlocProvider(
        create: (context) => AnuncioBloc(
          carregarAnuncio: context
              .read(), // Assumindo que CarregarAnuncio está registrado no contexto.
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Banner',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const BannerWidget(), // Widget de anúncio de banner.
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Carregar e mostrar anúncio intersticial.
                  intersticialWidget.carregarAnuncioIntersticial();
                  intersticialWidget.mostrarAnuncioIntersticial(context);
                },
                child: const Text('Mostrar Anúncio Intersticial'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Carregar e mostrar anúncio recompensado.
                  recompensadoWidget.carregarAnuncioRecompensado();
                  recompensadoWidget.mostrarAnuncioRecompensado(context);
                },
                child: const Text('Mostrar Anúncio Recompensado'),
              ),
              const SizedBox(height: 20),
              // Exibe o estado atual do bloco.
              BlocBuilder<AnuncioBloc, AnuncioState>(
                builder: (context, state) {
                  if (state is AnuncioLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is AnuncioCarregado) {
                    return Text('Anúncio carregado: ${state.anuncio.tipo}');
                  } else if (state is AnuncioErro) {
                    return Text('Erro: ${state.mensagem}');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
