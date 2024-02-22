import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../features/splash_screen/widgets/flutter_splash_screen.dart';
import 'loading_widgets/shimmer_loading.dart';

class MyCachedImage extends StatelessWidget {
  const MyCachedImage(
    this.imageUrl, {
    super.key,
    this.noShimmeringLoading = false,
    this.boxFit = BoxFit.cover,
  });

  final String? imageUrl;
  final bool noShimmeringLoading;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      fit: boxFit,
      placeholder: noShimmeringLoading
          ? null
          : (context, url) => Center(
                  child: ShimmeringEffect(
                child: Container(
                  color: Colors.white,
                ),
              )),
      errorWidget: (context, url, error) => const FlutterSplashScreen(),
    );
  }
}