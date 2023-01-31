/// Nekoton repository package
library nekoton_repository;

import 'package:injectable/injectable.dart';
export 'src/models/models.dart';
export 'src/nekoton_repository.dart';

// @microPackageInit => short const
@InjectableInit.microPackage()
initMicroPackage() {} // will not be called but needed for code generation
