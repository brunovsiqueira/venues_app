import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/exceptions/base/base_exception.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/models/section_model.dart';
import 'package:venues_app/src/providers/restaurants_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? _timer;

  final coordinates = [
    const CoordinatesModel(latitude: 60.170187, longitude: 24.930599),
    const CoordinatesModel(latitude: 60.169418, longitude: 24.931618),
    const CoordinatesModel(latitude: 60.169818, longitude: 24.932906),
    const CoordinatesModel(latitude: 60.170005, longitude: 24.935105),
    const CoordinatesModel(latitude: 60.169108, longitude: 24.936210),
    const CoordinatesModel(latitude: 60.168355, longitude: 24.934869),
    const CoordinatesModel(latitude: 60.167560, longitude: 24.932562),
    const CoordinatesModel(latitude: 60.168254, longitude: 24.931532),
    const CoordinatesModel(latitude: 60.169012, longitude: 24.930341),
    const CoordinatesModel(latitude: 60.170085, longitude: 24.929569),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      int index = 0;
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        final CoordinatesModel currentCoordinate = coordinates[index];
        ref.invalidate(restaurantsProvider(currentCoordinate));

        index = (index + 1) % coordinates.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<RestaurantsResponseModel> asyncResponse =
        ref.watch(restaurantsProvider(coordinates[0]));

    return Scaffold(
      appBar: AppBar(
        title: Text('Venues in Helsinki'),
      ),
      body: asyncResponse.when(
        data: (restaurantsResponse) {
          SectionModel? restaurantsSection =
              restaurantsResponse.deliveringRestaurants;

          if (restaurantsSection == null || restaurantsSection.items.isEmpty) {
            return Container(); //TODO: return something saying that the restaurant list is empty
          }

          return ListView.builder(
            itemCount: restaurantsSection.items.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantsSection.items[index];
              // final isFavorite =
              //     venue.isFavorite; // Replace with your favorite logic
              return ListTile(
                title: Text(restaurant.venue.name),
                subtitle: Text(restaurant.venue.shortDescription),
                leading: Image.network(restaurant.image.url),
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
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error: ${(error as BaseException).message}')),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
