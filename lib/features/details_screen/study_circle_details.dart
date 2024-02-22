import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/loading_widgets/about_us_section_loading.dart';
import 'widgets/loading_widgets/contact_section_loading.dart';
import 'widgets/loading_widgets/header_section_loading.dart';
import '../../config.dart';
import '../../widgets/loading_widgets/shimmer_loading.dart';
import 'widgets/details_screen_about_us_section.dart';
import 'widgets/details_screen_app_bar.dart';
import 'widgets/details_screen_contact_section.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/my_error_widget.dart';
import 'study_circle_details_repository/study_circle_repository.dart';
import 'widgets/details_screen_header.dart';


class StudyCircleDetails extends ConsumerWidget {
  const StudyCircleDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemId = ModalRoute.of(context)?.settings.arguments as String;
    final state = ref.watch(studyCircleRepositoryProvider(itemId));

    return switch (state) {
      AsyncLoading() => const _StudyCircleDetailsLoading(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: DetailsScreenAppBar(
                  title: context.localize?.study_circles ?? '')),
          body: ListView(
            children: [
              HeaderSection(
                logoImageUrl: value?.photo?.url ?? '',
                title: value?.name ?? '',
                backgroundImageUrl: value?.backgroundPhoto?.url ?? '',
                department: value?.department?.name ?? '',
              ),
              const SizedBox(height: DetailsScreenConfig.spacerHeight),
              ContactSection(
                list: value?.infoSection
                        ?.expand((e) => e?.info ?? [])
                        .map((a) => ContactSectionData(
                              iconUrl: a?.icon?.url,
                              text: a?.visibleText,
                              url: a?.value,
                              type: a?.type,
                            ))
                        .toList() ??
                    List.empty(),
              ),
              const SizedBox(height: DetailsScreenConfig.spacerHeight),
              AboutUsSection(
                text: value?.description ?? '',
              ),
            ],
          ),
        ),
    };
  }
}

class _StudyCircleDetailsLoading extends StatelessWidget {
  const _StudyCircleDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: DetailsScreenAppBar(
              title: context.localize?.study_circles ?? '')),
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HeaderSectionLoading(),
            SizedBox(height: DetailsScreenConfig.spacerHeight),
            ContactSectionLoading(),
            SizedBox(height: DetailsScreenConfig.spacerHeight),
            AboutUsSectionLoading()
          ],
        ),
      ),
    );
  }
}

