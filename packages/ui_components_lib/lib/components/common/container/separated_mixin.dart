import 'package:flutter/widgets.dart';

mixin SeparatedMixin on MultiChildRenderObjectWidget {
  static List<Widget> buildChildren(Widget separator, List<Widget> children) {
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i != children.length - 1) {
        result.add(separator);
      }
    }

    return result;
  }
}
