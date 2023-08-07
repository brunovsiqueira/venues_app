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
import 'package:venues_app/src/widgets/restaurant_item_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          List<SectionItemModel> restaurantsItems =
              restaurantsSection.items.map((item) {
            if (favoriteRestaurantsIds.contains(item.venue?.id)) {
              item = item.copyWith(isFavorite: true);
            }
            return item;
          }).toList();
          restaurantsItems.sort((a, b) => b.isFavorite ? 1 : -1);

          return ListView.builder(
            itemCount: restaurantsItems.length,
            itemBuilder: (context, index) {
              SectionItemModel restaurantSectionItem = restaurantsItems[index];

              if (restaurantSectionItem.venue == null) {
                return null;
              }
              return RestaurantItemWidget(item: restaurantSectionItem);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          return Center(
            child: Column(
              children: [
                Text(
                  (error as BaseException).message,
                ),
                GestureDetector(
                  child: const Icon(Icons.refresh),
                  onTap: () {
                    ref.invalidate(restaurantsProvider(coordinates));
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
