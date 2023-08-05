import 'package:equatable/equatable.dart';
import 'package:venues_app/src/models/section_item_model.dart';

class SectionModel extends Equatable {
  final List<SectionItemModel> items;
  final String title;
  final String name;

  const SectionModel({
    required this.items,
    required this.title,
    required this.name,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      items: json['items'] != null
          ? (json['items'] as List)
              .map((e) => SectionItemModel.fromJson(e))
              .take(15)
              .toList()
          : [],
      title: json['title'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
        items,
        title,
        name,
      ];
}
