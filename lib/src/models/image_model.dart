import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String blurhash;
  final String url;

  const ImageModel({
    required this.blurhash,
    required this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      blurhash: json['blurhash'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [blurhash, url];
}
