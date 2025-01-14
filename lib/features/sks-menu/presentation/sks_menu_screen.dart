import "dart:core";

import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../home_view/widgets/paddings.dart";
import "../data/models/dish_category_enum.dart";
import "../data/models/sks_menu_data.dart";
import "../data/repository/sks_menu_repository.dart";
import "widgets/sks_menu_data_source_link.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";

@RoutePage()
class SksMenuView extends ConsumerWidget {
  const SksMenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksMenuData = ref.watch(getSksMenuDataProvider);

    // TODO(mikolaj-jalocha): Add lottie animation on: error and when data is empty (sks's closed)
    return asyncSksMenuData.when(
      data: (sksMenuData) =>
          _SksMenuView(asyncSksMenuData.value ?? const IMap.empty()),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Error: $error"),
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _SksMenuView extends StatelessWidget {
  const _SksMenuView(this.sksMenuData);

  final IMap<DishCategory, List<SksMenuDish>> sksMenuData;

  @override
  Widget build(BuildContext context) {
    if (sksMenuData.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final firstItem = sksMenuData.values.first.first;
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.home_screen),
      body: ListView(
        children: [
          SksMenuHeader(
            dateTimeOfLastUpdate: firstItem.updatedAt.toIso8601String(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: HomeViewConfig.paddingMedium,
            ),
            child: MediumHorizontalPadding(child: SksMenuSection(sksMenuData)),
          ),
          const SksMenuDataSourceLink(),
          const SizedBox(
            height: ScienceClubsViewConfig.mediumPadding,
          ),
        ],
      ),
    );
  }
}
