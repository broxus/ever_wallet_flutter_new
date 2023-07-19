import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default paddings of application
class CommonPadding extends Padding {
  const CommonPadding.xsmall({super.key, super.child})
      : super(padding: const EdgeInsets.all(DimensSize.d4));

  const CommonPadding.small({super.key, super.child})
      : super(padding: const EdgeInsets.all(DimensSize.d8));

  const CommonPadding.medium({super.key, super.child})
      : super(padding: const EdgeInsets.all(DimensSize.d12));

  const CommonPadding.large({super.key, super.child})
      : super(padding: const EdgeInsets.all(DimensSize.d16));

  const CommonPadding.xlarge({super.key, super.child})
      : super(padding: const EdgeInsets.all(DimensSize.d24));
}
