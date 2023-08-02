import 'dart:typed_data';

import 'package:blurhash/blurhash.dart';
import 'package:flutter/material.dart';

class BlurhashWidget extends StatefulWidget {
  final String blurhash;
  const BlurhashWidget({
    required this.blurhash,
    super.key,
  });

  @override
  State<BlurhashWidget> createState() => _BlurhashWidgetState();
}

class _BlurhashWidgetState extends State<BlurhashWidget> {
  Uint8List? _imageDataBytes;

  @override
  void initState() {
    super.initState();
    blurHashDecode(widget.blurhash);
  }

  Future blurHashDecode(String blurhash) async {
    Uint8List? imageDataBytes;

    imageDataBytes = await BlurHash.decode(blurhash, 100, 32);

    setState(() {
      _imageDataBytes = imageDataBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_imageDataBytes == null) {
      return Container(); //TODO: use shimmer
    }
    return Image.memory(
      _imageDataBytes!,
      fit: BoxFit.fill,
    );
  }
}
