import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/routes.dart';
import 'package:venues_app/src/widgets/favorite_widget.dart';
import 'package:venues_app/src/widgets/shimmer_widget.dart';

class RestaurantItemWidget extends StatelessWidget {
  final SectionItemModel item;

  const RestaurantItemWidget({
    required this.item,
    super.key,
  });

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
        trailing: FavoriteWidget(
          item: item,
        ));
  }
}
