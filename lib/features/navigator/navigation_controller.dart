import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/nav_bar_config.dart";

part "navigation_controller.g.dart";

typedef TRoute = PageRouteInfo<dynamic>;

typedef NavigationState = ({
  bool isStackPoppable,
  NavBarEnum activeTab,
});

@riverpod
GlobalKey<AutoRouterState> navigatorKey(Ref ref) {
  return GlobalKey<AutoRouterState>();
}

@riverpod
class NavigationController extends _$NavigationController {
  GlobalKey<AutoRouterState> get _navigatorKey =>
      ref.watch(navigatorKeyProvider);

  StackRouter? get _router => _navigatorKey.currentState?.controller;

  Iterable<TRoute> get _stack =>
      _router?.stackData.map((e) => e.route.toPageRouteInfo()) ?? [];

  Future<void> keepTrackOfTabBarState(Future<void>? popFutureResults) async {
    await Future.delayed(
      Duration.zero,
      refreshState, // refresh the state after the push
    );
    // await the route's pop
    if (popFutureResults != null) await popFutureResults;
    refreshState(); // refresh the state after the pop
  }

  Future<void> push(TRoute route) async {
    final popFutureResults = _router?.push(route); // push the route
    await keepTrackOfTabBarState(popFutureResults);
  }

  Future<void> pushNamed(String uri) async {
    final popFutureResults = _router?.pushNamed(uri); // push the route
    await keepTrackOfTabBarState(popFutureResults);
  }

  /// this is called only when you actually **click** in the nav tab bar
  /// so we don't call this on other navigation actions (like `Lista >` buttons)
  Future<void> onTabBarChange(NavBarEnum item) async {
    final route = NavBarConfig.tabViews[item]!;
    if (_stack.last.routeName != route.routeName) {
      _popUntilTabBarView();
      await push(route);
    }
  }

  /// pops details views above tab views
  void _popUntilTabBarView() {
    _router?.popUntil(
      (element) =>
          element.settings is! AutoRoutePage ||
          (element.settings as AutoRoutePage)
              .routeData
              .topMatch
              .toPageRouteInfo()
              .isTabView,
    );
  }

  void refreshState() {
    state = build();
  }

  @override
  NavigationState build() {
    return (
      isStackPoppable: _stack.length > 1,
      activeTab:
          _stack.lastWhereOrNull((element) => element.isTabView)?.tabBarEnum ??
              NavBarEnum.home,
    );
  }
}
