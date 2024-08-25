// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/constants.dart';

/// O BannerWidget é responsável por exibir um anúncio de banner
/// na interface do usuário. Ele utiliza o pacote google_mobile_ads
/// para carregar e renderizar o anúncio.

class BannerWidget extends StatefulWidget {
  /// Construtor do BannerWidget.
  ///
  /// Inicializa o widget de anúncio de banner.
  const BannerWidget({super.key});

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  /// A instância do anúncio de banner.
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // Carrega o anúncio de banner ao inicializar o widget.
    _loadBannerAd();
  }

  @override
  void dispose() {
    // Descarrega o anúncio quando o widget é removido da árvore de widgets.
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Carrega o anúncio de banner.
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Constants.adUnitIdBanner, // ID da unidade de anúncio de banner.
      size: AdSize.banner, // Tamanho do anúncio de banner.
      request: const AdRequest(),
      listener: BannerAdListener(
        // Chamado quando um anúncio é carregado com sucesso.
        onAdLoaded: (Ad ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Chamado quando um anúncio falha ao carregar.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Falha ao carregar BannerAd: $error');
          ad.dispose();
        },
      ),
    );

    // Inicia o carregamento do anúncio.
    _bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _bannerAd?.size.width.toDouble() ?? 0,
      height: _bannerAd?.size.height.toDouble() ?? 0,
      child: _bannerAd == null
          ? const SizedBox
              .shrink() // Retorna um widget vazio se o anúncio não estiver carregado.
          : AdWidget(ad: _bannerAd!), // Renderiza o widget do anúncio.
    );
  }
}
