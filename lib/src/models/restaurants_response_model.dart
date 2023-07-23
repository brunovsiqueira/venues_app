import 'package:venues_app/src/models/section_model.dart';

class RestaurantResponseModel {
  final String pageTitle;
  final List<SectionModel> sections;

  RestaurantResponseModel({
    required this.pageTitle,
    required this.sections,
  });

  factory RestaurantResponseModel.fromJson(Map<String, dynamic> json) {
    return RestaurantResponseModel(
      pageTitle: json['page_title'],
      sections: (json['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList(),
    );
  }
}
