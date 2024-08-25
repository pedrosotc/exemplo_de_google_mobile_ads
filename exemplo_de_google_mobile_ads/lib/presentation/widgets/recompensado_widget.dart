import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/constants.dart';

/// O RecompensadoWidget é responsável por gerenciar e exibir
/// anúncios recompensados. Ele utiliza o pacote google_mobile_ads
/// para lidar com o ciclo de vida do anúncio e gerenciar recompensas.

class RecompensadoWidget {
  /// A instância do anúncio recompensado.
  RewardedAd? _rewardedAd;

  /// Cria e carrega um anúncio recompensado.
  ///
  /// O anúncio será carregado, mas não será exibido automaticamente.
  void carregarAnuncioRecompensado() {
    RewardedAd.load(
      adUnitId:
          Constants.adUnitIdRewarded, // ID da unidade de anúncio recompensado.
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Chamado quando o anúncio é carregado com sucesso.
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          debugPrint('Anúncio recompensado carregado.');
        },
        // Chamado quando o anúncio não é carregado.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Falha ao carregar anúncio recompensado: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

  /// Exibe o anúncio recompensado carregado.
  ///
  /// Se o anúncio não estiver carregado, a função não faz nada.
  void mostrarAnuncioRecompensado(BuildContext context) {
    if (_rewardedAd == null) {
      debugPrint('Anúncio recompensado ainda não carregado.');
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      // Chamado quando o anúncio é mostrado.
      onAdShowedFullScreenContent: (RewardedAd ad) {
        debugPrint('Anúncio recompensado exibido.');
      },
      // Chamado quando o anúncio falha ao ser exibido.
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('Falha ao exibir anúncio recompensado: $error');
        ad.dispose();
        _rewardedAd = null;
      },
      // Chamado quando o anúncio é fechado pelo usuário.
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('Anúncio recompensado fechado.');
        ad.dispose();
        _rewardedAd = null;
        // Opcional: carregar outro anúncio recompensado após o fechamento.
        carregarAnuncioRecompensado();
      },
    );

    // Define a função de callback para quando o usuário deve ser recompensado.
    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        // Atribua a recompensa ao usuário aqui.
        debugPrint(
            'Usuário ganhou recompensa: ${reward.amount} ${reward.type}');
        // Implementar lógica para conceder recompensa ao usuário.
      },
    );
  }

  /// Descarta o anúncio recompensado quando não é mais necessário.
  void dispose() {
    _rewardedAd?.dispose();
  }
}
