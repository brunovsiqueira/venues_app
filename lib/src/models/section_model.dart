import 'package:venues_app/src/models/section_item_model.dart';

class SectionModel {
  final List<SectionItemModel> items;
  final String title;

  SectionModel({
    required this.items,
    required this.title,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      items: (json['items'] as List)
          .map((e) => SectionItemModel.fromJson(e))
          .toList(),
      title: json['title'],
    );
  }
}