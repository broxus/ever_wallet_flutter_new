import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/enter_seed_name/view/enter_seed_name_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Commands that will be used to choose where to navigate after entering name
const enterSeedNameImportCommand = 'import';
const enterSeedNameCreateCommand = 'create';

/// {@template enter_seed_name_create_page}
/// Page that allows user to enter seed name, used only in profile section as
/// a STARTING screen in seed CREATING or IMPORTING flows.
/// {@endtemplate}
class EnterSeedNamePage extends StatelessWidget {
  /// {@macro enter_seed_name_create_page}
  const EnterSeedNamePage({
    required this.command,
    super.key,
  });

  final String command;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(),
        body: EnterSeedNameView(
          // ignore: prefer-extracting-callbacks
          callback: (name) {
            final query = name == null ? null : {'name': name};
            final path = command == enterSeedNameImportCommand
                ? AppRoute.enterSeed.pathWithQuery(query)
                : AppRoute.createSeed.pathWithQuery(query);
            context.goFurther(path);
          },
        ),
      ),
    );
  }
}
