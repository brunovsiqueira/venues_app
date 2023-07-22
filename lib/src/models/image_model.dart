class ImageModel {
  final String blurhash;
  final String url;

  ImageModel(this.blurhash, this.url);

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      json['blurhash'],
      json['url'],
    );
  }
}
