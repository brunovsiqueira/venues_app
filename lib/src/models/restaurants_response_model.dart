import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:venues_app/src/models/section_model.dart';

class RestaurantsResponseModel extends Equatable {
  final String pageTitle;
  final List<SectionModel> sections;

  SectionModel? get deliveringRestaurantsSection => sections.firstWhereOrNull(
      (element) => element.name == 'restaurants-delivering-venues');

  const RestaurantsResponseModel({
    required this.pageTitle,
    required this.sections,
  });

  factory RestaurantsResponseModel.fromJson(Map<String, dynamic> json) {
    return RestaurantsResponseModel(
      pageTitle: json['page_title'],
      sections: (json['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [pageTitle, sections];
}
