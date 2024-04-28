import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../widgets/my_cached_image.dart';
import '../../../widgets/wide_tile_card.dart';
import '../repositories/scientific_circles_repository.dart';

class ResearchGroupCard extends StatelessWidget {
  final ScientificCircle sciCircle;
  final VoidCallback? onTap;
  const ResearchGroupCard(this.sciCircle, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      isActive: false,
      title: sciCircle.name,
      subtitle: sciCircle.department?.name ?? "",
      onTap: onTap,
      secondSubtitle:
          sciCircle.tags?.map((tag) => '#${tag?.name}').toList().join(', '),
      activeShadows: null,
      trailing: Padding(
        padding: const EdgeInsets.only(
            right: ScientificCircleCardConfig.trailingPadding,
            top: ScientificCircleCardConfig.trailingPadding,
            bottom: ScientificCircleCardConfig.trailingPadding),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: WideTileCardConfig.radius,
                  bottomRight: WideTileCardConfig.radius),
            ),
            child: MyCachedImage(
              sciCircle.photo?.url,
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}