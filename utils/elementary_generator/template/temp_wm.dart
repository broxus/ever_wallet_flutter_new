import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'temp.dart';
import 'temp_model.dart';

/// Factory method for creating [$Temp$WidgetModel]
$Temp$WidgetModel default$Temp$WidgetModelFactory(
  BuildContext context,
) {
  return $Temp$WidgetModel(
    $Temp$Model(
      createPrimaryErrorHandler(context),
    ),
  );
}

/// [WidgetModel] для [$Temp$]
class $Temp$WidgetModel extends CustomWidgetModel<$Temp$, $Temp$Model> {
  $Temp$WidgetModel(
    super.model,
  );
}
