import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'domain/usecases/carregar_anuncio.dart';

void main() async {
  // Assegura que os widgets são inicializados corretamente.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o SDK de anúncios móveis antes de executar o aplicativo.
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

/// O MyApp é o widget raiz do aplicativo, configurando o tema
/// e definindo a tela inicial como HomePage.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Registra o caso de uso CarregarAnuncio no contexto do aplicativo.
        RepositoryProvider(
          create: (context) => CarregarAnuncio(),
        ),
      ],
      child: MaterialApp(
        title: 'Anúncios App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
