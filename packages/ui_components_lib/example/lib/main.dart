import 'package:example/widgets/story.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: everPredefinedLightTheme(),
      darkTheme: everPredefinedDarkTheme(),
      home: const StoryWidget(),
    ),
  );
}
