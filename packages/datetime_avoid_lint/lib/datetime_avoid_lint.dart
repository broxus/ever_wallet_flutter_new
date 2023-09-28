// import 'dart:isolate';

import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _ExampleLinter();

/// A plugin class is used to list all the assists/lints defined by a plugin.
class _ExampleLinter extends PluginBase {
  /// We list all the custom warnings/infos/errors
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        MyCustomLintCode(),
      ];
}

class MyCustomLintCode extends DartLintRule {
  MyCustomLintCode() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'avoid_datetime_now',
    problemMessage:
        'Use NtpTime.now() instead of DateTime.now() and NtpTime.clockNow() instead of clock.now()',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Yeah, this is a hack, but it works
    context.registry.addMethodInvocation((node) {
      final s = node.toString();
      if (s.contains('now()')) {
        if (s.contains('DateTime') || s.contains('clock')) {
          reporter.reportErrorForNode(code, node);
        }
      }
    });
  }
}
