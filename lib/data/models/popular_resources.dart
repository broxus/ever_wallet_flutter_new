import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';

@immutable
class PopularResources {
  const PopularResources({
    required this.name,
    required this.url,
    required this.image,
  });

  final String name;
  final String url;
  final SvgGenImage image;
}
