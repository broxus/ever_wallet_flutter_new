import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/feature/add_seed/enter_seed_name/view/enter_seed_name_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template enter_seed_name_page}
/// Page that allows user to enter seed name, used only in profile section
/// during seed adding.
/// {@endtemplate}
class EnterSeedNamePage extends StatelessWidget {
  /// {@macro enter_seed_name_page}
  const EnterSeedNamePage({
    required this.extra,
    super.key,
  });

  final CreateSeedRouteExtra extra;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(),
        body: EnterSeedNameView(
          callback: (String? name) {
            context.goFurther(
              AppRoute.createSeedPassword.path,
              extra: CreateSeedRouteExtra(phrase: extra.phrase, name: name),
            );
          },
        ),
      ),
    );
  }
}
