import "package:anim_search_bar/anim_search_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../filters_search_controller.dart";

const padding = 15.0;

class FiltersSearch extends ConsumerStatefulWidget {
  const FiltersSearch({super.key});

  @override
  ConsumerState<FiltersSearch> createState() => _FiltersSearchState();
}

class _FiltersSearchState extends ConsumerState<FiltersSearch> {
  bool isExpanded = false;
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: ref.read(searchFiltersControllerProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expandedWidth = MediaQuery.sizeOf(context).width -
        2 * padding -
        MediaQuery.viewInsetsOf(context).horizontal;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isExpanded ? padding : 67,
      top: 16,
      child: AnimSearchBar(
        width: expandedWidth,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            isExpanded = false; // let's say this lib is stupid has problems
          });
        },
        onSubmitted: (s) {
          setState(() {
            isExpanded = false; // let's say this lib is stupid has problems
          });
        },
        onChanged: ref
            .watch(searchFiltersControllerProvider.notifier)
            .onTextChanged, // I had to fork the lib and add this callback myself 😭
        textFieldColor: context.colorTheme.greyLight,
        textFieldIconColor: context.colorTheme.blackMirage,
        color: context.colorTheme.whiteSoap,
        closeSearchOnSuffixTap: true,
        autoFocus: true,
        searchIconColor: context.colorTheme.blackMirage,
        helpText: context.localize.search,
        boxShadow: false,
        searchBarOpen: (int x) {
          setState(() {
            isExpanded = x == 1; // this lib is stupid as f...
          });
        },
        height: 48,
      ),
    );
  }
}
