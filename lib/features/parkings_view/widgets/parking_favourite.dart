import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/iparking_theme.dart";
import "../models/parking.dart";
import "../repository/local_fav_parking_repository.dart";

class FavouriteParkingWidget extends ConsumerWidget {
  const FavouriteParkingWidget(this.parking);
  final Parking parking;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favController =
        ref.watch(localFavParkingsRepositoryProvider(parking.id).notifier);
    final isFavorite =
        ref.watch(localFavParkingsRepositoryProvider(parking.id));
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: favController.toggle,
      icon: isFavorite == null
          ? const FavouriteIcon(
              icon: Icons.error,
            )
          : FavouriteIcon(
              icon: isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_outlined,
            ),
    );
  }
}

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: context.colorTheme.whiteSoap,
      size: 22,
      shadows: iparkingShadows,
    );
  }
}