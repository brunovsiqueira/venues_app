import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/models/venue_model.dart';
import 'package:venues_app/src/widgets/favorite_widget.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as SectionItemModel;
    VenueModel? venue = item.venue;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'venue_image${venue?.id}',
            child: CachedNetworkImage(
              imageUrl: item.image.url,
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => const ShimmerWidget(
                width: 100,
                height: double.infinity,
              ),
              errorWidget: (context, url, error) => Container(),
            ),
          ),
          if (venue?.name != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        venue!.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  FavoriteWidget(item: item),
                ],
              ),
            ),
          if (venue?.shortDescription != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                venue!.shortDescription!,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          if (venue?.score != null)
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 16.0),
              child: Row(children: [
                const Icon(Icons.star),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${venue!.score}/10'),
                )
              ]),
            ),
          if (venue?.distance != null)
            ListTile(
              title: Text(
                  '${venue!.distance!} • ${venue.deliveryPrice} • ${venue.estimateRange} min'),
            ),
        ],
      ),
    );
  }
}
