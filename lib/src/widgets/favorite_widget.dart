// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/providers/favorite_restaurants_provider.dart';

class FavoriteWidget extends ConsumerStatefulWidget {
  SectionItemModel item;
  FavoriteWidget({
    required this.item,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends ConsumerState<FavoriteWidget> {
  late SectionItemModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        item.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: item.isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        setState(() {
          item = item.copyWith(isFavorite: !item.isFavorite);
        });
        if (item.isFavorite) {
          ref
              .read(favoriteRestaurantsControllerProvider)
              .addFavoriteRestaurantId(item.venue!.id);
        } else {
          ref
              .read(favoriteRestaurantsControllerProvider)
              .removeFavoriteRestaurantId(item.venue!.id);
        }
      },
    );
  }
}
