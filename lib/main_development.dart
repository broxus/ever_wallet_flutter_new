import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
var a = 1;
void main() {
  bootstrap(
    () => const AppPage(),
    AppBuildType.development,
  );
}
