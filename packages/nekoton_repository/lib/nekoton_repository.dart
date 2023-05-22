/// Nekoton repository package
library nekoton_repository;

import 'package:injectable/injectable.dart';

export 'package:flutter_nekoton_bridge/flutter_nekoton_bridge.dart';

export 'src/models/models.dart';
export 'src/nekoton_repository.dart';
export 'src/repositories/repositories.dart';

// ignore_for_file: always_declare_return_types
// ignore_for_file: inference_failure_on_function_return_type
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_annotate_public_apis

// @microPackageInit => short const
@InjectableInit.microPackage()
initMicroPackage() {} // will not be called but needed for code generation
