/// Encrypted storage
library encrypted_storage;

import 'package:injectable/injectable.dart';

export 'src/abstract_storage.dart';
export 'src/encrypted_storage.dart';

// ignore_for_file: always_declare_return_types
// ignore_for_file: inference_failure_on_function_return_type
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_annotate_public_apis

// @microPackageInit => short const
@InjectableInit.microPackage()
initMicroPackage() {} // will not be called but needed for code generation
