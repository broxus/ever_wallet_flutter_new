import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/enter_seed_name/view/enter_seed_name_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Name of path field for navigation
const enterSeedNameCommand = 'command';

/// Name of path field for navigation
const enterSeedNameName = 'name';

/// Commands that will be used to choose where to navigate after entering name
enum EnterSeedNameCommand {
  import('import'),
  create('create');

  const EnterSeedNameCommand(this.name);

  final String name;

  static EnterSeedNameCommand getByName(String? name) {
    // ignore: prefer-enums-by-name
    return EnterSeedNameCommand.values.firstWhere(
      (element) => element.name == name,
      orElse: () => create,
    );
  }
}

/// {@template enter_seed_name_create_page}
/// Page that allows user to enter seed name, used only in profile section as
/// a STARTING screen in seed CREATING or IMPORTING flows.
/// {@endtemplate}
class EnterSeedNamePage extends StatelessWidget {
  /// {@macro enter_seed_name_create_page}
  const EnterSeedNamePage({
    required this.commandName,
    super.key,
  });

  final String? commandName;

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
            final command = EnterSeedNameCommand.getByName(commandName);

            final path = switch (command) {
              EnterSeedNameCommand.import => name == null
                  ? AppRoute.enterSeed.path
                  : AppRoute.enterSeedNamed.pathWithData(name),
              EnterSeedNameCommand.create => name == null
                  ? AppRoute.createSeed.path
                  : AppRoute.createSeedNamed.pathWithData(name),
            };

            context.goFurther(path);
          },
        ),
      ),
    );
  }
}
