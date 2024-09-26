import 'package:app/app/view/app.dart';
import 'package:app/bootstrap.dart';

void main() {
  bootstrap(
    () => const App(),
    AppBuildType.staging,
  );
}
