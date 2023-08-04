import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/providers/favorite_restaurants_provider.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class VenueItemWidget extends ConsumerStatefulWidget {
  final SectionItemModel venueItem;
  const VenueItemWidget({
    required this.venueItem,
    super.key,
  });

  @override
  ConsumerState<VenueItemWidget> createState() => _VenueItemWidgetState();
}

class _VenueItemWidgetState extends ConsumerState<VenueItemWidget> {
  late SectionItemModel venueItem;
  @override
  void initState() {
    super.initState();
    venueItem = widget.venueItem;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(venueItem.venue!.name),
      subtitle: Text(venueItem.venue!.shortDescription ?? ''),
      leading: CachedNetworkImage(
        imageUrl: venueItem.image.url,
        width: 100,
        fit: BoxFit.fill,
        placeholder: (context, url) => const ShimmerWidget(
          width: 100,
          height: double.infinity,
        ),
        errorWidget: (context, url, error) => Container(),
      ),
      trailing: IconButton(
        icon:
            Icon(venueItem.isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          setState(() {
            venueItem = venueItem.copyWith(isFavorite: !venueItem.isFavorite);
          });
          if (venueItem.isFavorite) {
            ref
                .read(favoriteRestaurantsControllerProvider)
                .addFavoriteRestaurantId(venueItem.venue!.id);
          } else {
            ref
                .read(favoriteRestaurantsControllerProvider)
                .removeFavoriteRestaurantId(venueItem.venue!.id);
          }
        },
      ),
    );
  }
}
