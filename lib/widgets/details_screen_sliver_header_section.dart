import 'dart:math';
import 'package:flutter/material.dart';
import '../config/ui_config.dart';
import 'my_cached_image.dart';

class SliverHeaderSection extends SliverPersistentHeaderDelegate {
  SliverHeaderSection({
    this.activeGradient,
    required this.logoImageUrl,
    required this.backgroundImageUrl,
  });

  final String? logoImageUrl;
  final String? backgroundImageUrl;
  final LinearGradient? activeGradient;
  static const maxTopBarHeight = 250;

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 0;

  double calcLogoSize(double shrinkOffset) {
    final ratio = min(1, shrinkOffset / DetailsScreenHeaderConfig.logoSize);
    final adjustedRatio = 1.0 - (ratio * 0.3);
    return max(0.0, DetailsScreenHeaderConfig.logoSize * adjustedRatio);
  }

  double calcLogoOpacity(double shrinkOffset, double logoSize) {
    final spaceLeft = maxExtent - shrinkOffset;
    final adjustedRatio = -(spaceLeft - logoSize) / logoSize;
    return 1.0 - max(0, adjustedRatio);
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;
    final logoSize = calcLogoSize(shrinkOffset);
    final logoOpacity = calcLogoOpacity(shrinkOffset, logoSize);
    final scaleFactor = activeGradient != null ? 0.5 : 1.0;
    return Stack(
      children: [
        Opacity(
          opacity: 1 - progress,
          child: SizedBox(
            height: maxTopBarHeight * (1 - progress),
            width: double.infinity,
            child: MyCachedImage(backgroundImageUrl),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox.square(
              child: ListView(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Opacity(
                    opacity: logoOpacity,
                    child: Card(
                      elevation: 3,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          gradient: activeGradient,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: MyCachedImage(
                            size: Size.square(logoSize * scaleFactor),
                            logoImageUrl,
                            boxFit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}