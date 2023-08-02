import 'dart:async';
import 'dart:typed_data';

import 'package:blurhash/blurhash.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/exceptions/base/base_exception.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/models/section_model.dart';
import 'package:venues_app/src/providers/restaurants_coordinates_provider.dart';
import 'package:venues_app/src/providers/restaurants_provider.dart';
import 'package:venues_app/src/widgets/blurhash_widget.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? _timer;

  final coordinates = [
    const CoordinatesModel(latitude: 60.170187, longitude: 24.930599),
    const CoordinatesModel(latitude: 20.169418, longitude: 20.931618),
  ];

  CoordinatesModel? currentCoordinates;
  Uint8List? _imageDataBytes;

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
          SectionModel? restaurantsSection =
              restaurantsResponse.deliveringRestaurants;

          if (restaurantsSection == null || restaurantsSection.items.isEmpty) {
            return const Center(child: Text('No restaurants found'));
          }

          return ListView.builder(
            itemCount: restaurantsSection.items.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantsSection.items[index];
              // final isFavorite =
              //     venue.isFavorite; // Replace with your favorite logic

              return ListTile(
                title: Text(restaurant.venue?.name ?? ''),
                subtitle: Text(restaurant.venue?.shortDescription ?? ''),
                leading: CachedNetworkImage(
                  imageUrl: restaurant.image.url,
                  width: 100,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const ShimmerWidget(
                    width: 100,
                    height: double.infinity,
                  ),
                  errorWidget: (context, url, error) => Container(),
                ),
                // trailing: IconButton(
                //   icon:
                //       Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                //   onPressed: () {
                //     // Handle favorite toggle logic here
                //   },
                // ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          //TODO: handle response as exception
          return Center(child: Text((error as BaseException).message));
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
