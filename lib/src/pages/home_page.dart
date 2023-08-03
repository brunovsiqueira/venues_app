import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/exceptions/base/base_exception.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/models/section_model.dart';
import 'package:venues_app/src/providers/favorite_restaurants_provider.dart';
import 'package:venues_app/src/providers/restaurants_coordinates_provider.dart';
import 'package:venues_app/src/providers/restaurants_provider.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  CoordinatesModel? currentCoordinates;

  @override
  Widget build(BuildContext context) {
    final CoordinatesModel coordinates =
        ref.watch(restaurantCoordinatesProvider);
    AsyncValue<RestaurantsResponseModel> asyncResponse =
        ref.watch(restaurantsProvider(coordinates));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Venues in Helsinki'),
      ),
      body: asyncResponse.when(
        skipLoadingOnRefresh: false,
        data: (restaurantsResponse) {
          List<String> favoriteRestaurantsIds = ref
              .read(favoriteRestaurantsControllerProvider)
              .favoriteRestaurantsIds;
          SectionModel? restaurantsSection =
              restaurantsResponse.deliveringRestaurantsSection;

          if (restaurantsSection == null || restaurantsSection.items.isEmpty) {
            return const Center(child: Text('No restaurants found'));
          }

          return ListView.builder(
            itemCount: restaurantsSection.items.length,
            itemBuilder: (context, index) {
              SectionItemModel restaurantSectionItem =
                  restaurantsSection.items[index];
              restaurantSectionItem = restaurantSectionItem.copyWith(
                  isFavorite: favoriteRestaurantsIds
                      .contains(restaurantSectionItem.venue?.id));
              if (restaurantSectionItem.venue == null) {
                return null;
              }
              return VenueItemWidget(venueItem: restaurantSectionItem);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(
              child: Text(
                  (error as BaseException).message)); //TODO: handle refresh
        },
      ),
    );
  }
}

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
