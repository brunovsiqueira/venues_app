import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/widgets/favorite_widget.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as SectionItemModel;
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: 'venue_image${item.venue?.id}',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
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
            if (item.venue?.name != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        item.venue!.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    FavoriteWidget(item: item),
                  ],
                ),
              ),
            if (item.venue?.shortDescription != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  item.venue!.shortDescription!,
                  style: const TextStyle(fontSize: 16),
                ),
              )
          ],
        ),
      ),
    );
  }
}
