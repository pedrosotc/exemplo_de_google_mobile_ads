// presentation/widgets/intersticial_widget.dart

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/constants.dart';

/// O IntersticialWidget é responsável por gerenciar e exibir
/// anúncios intersticiais na interface do usuário. Ele utiliza
/// o pacote google_mobile_ads para gerenciar o ciclo de vida do anúncio.

class IntersticialWidget {
  /// A instância do anúncio intersticial.
  InterstitialAd? _interstitialAd;

  /// Cria e carrega um anúncio intersticial.
  ///
  /// O anúncio será carregado, mas não será exibido automaticamente.
  void carregarAnuncioIntersticial() {
    InterstitialAd.load(
      adUnitId: Constants
          .adUnitIdInterstitial, // ID da unidade de anúncio intersticial.
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Chamado quando o anúncio é carregado com sucesso.
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          debugPrint('Anúncio intersticial carregado.');
        },
        // Chamado quando o anúncio não é carregado.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Falha ao carregar anúncio intersticial: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Exibe o anúncio intersticial carregado.
  ///
  /// Se o anúncio não estiver carregado, a função não faz nada.
  void mostrarAnuncioIntersticial(BuildContext context) {
    if (_interstitialAd == null) {
      debugPrint('Anúncio intersticial ainda não carregado.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      // Chamado quando o anúncio é mostrado.
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        debugPrint('Anúncio intersticial exibido.');
      },
      // Chamado quando o anúncio falha ao ser exibido.
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('Falha ao exibir anúncio intersticial: $error');
        ad.dispose();
        _interstitialAd = null;
      },
      // Chamado quando o anúncio é fechado pelo usuário.
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('Anúncio intersticial fechado.');
        ad.dispose();
        _interstitialAd = null;
        // Opcional: carregar outro anúncio intersticial após o fechamento.
        carregarAnuncioIntersticial();
      },
    );

    _interstitialAd!.show();
  }

  /// Descarta o anúncio intersticial quando não é mais necessário.
  void dispose() {
    _interstitialAd?.dispose();
  }
}
