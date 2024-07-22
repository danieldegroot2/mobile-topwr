
import 'package:flutter/cupertino.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/wide_tile_card.dart';

class FieldsOfStudySection extends StatelessWidget {
  const FieldsOfStudySection({Key? key, required this.fieldsOfStudy})
      : super(key: key);

  final List<String> fieldsOfStudy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize.fields_of_study,
              style: context.textTheme.headline),
          const SizedBox(height: 16),
          for (final item in fieldsOfStudy)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: WideTileCard(
                title: item,
              ),
            )
        ],
      ),
    );
  }
}