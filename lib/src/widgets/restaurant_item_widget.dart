import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/providers/favorite_restaurants_provider.dart';
import 'package:venues_app/src/routes.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class RestaurantItemWidget extends ConsumerStatefulWidget {
  final SectionItemModel venueItem;
  const RestaurantItemWidget({
    required this.venueItem,
    super.key,
  });

  @override
  ConsumerState<RestaurantItemWidget> createState() => _VenueItemWidgetState();
}

class _VenueItemWidgetState extends ConsumerState<RestaurantItemWidget> {
  late SectionItemModel item;
  @override
  void initState() {
    super.initState();
    item = widget.venueItem;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.venue!.name),
      subtitle: Text(item.venue!.shortDescription ?? ''),
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.restaurantDetails, arguments: item);
      },
      leading: Hero(
        tag: 'venue_image${item.venue?.id}',
        child: CachedNetworkImage(
          imageUrl: item.image.url,
          width: 100,
          fit: BoxFit.fill,
          placeholder: (context, url) => const ShimmerWidget(
            width: 100,
            height: double.infinity,
          ),
          errorWidget: (context, url, error) => Container(),
        ),
      ),
      trailing: IconButton(
        icon: Icon(item.isFavorite ? Icons.favorite : Icons.favorite_border),
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
      ),
    );
  }
}
