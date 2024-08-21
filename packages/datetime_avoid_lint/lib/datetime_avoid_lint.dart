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
        const MyCustomLintCode(),
      ];
}

class MyCustomLintCode extends DartLintRule {
  const MyCustomLintCode() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'avoid_datetime_now',
    problemMessage:
        // ignore: lines_longer_than_80_chars
        'Use NtpTime.now() instead of DateTime.now() and NtpTime.clockNow() instead of clock.now()',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Yeah, this is a hack, but it works
    // TODO(nesquikm): make some research and find a better way to do this
    // for example, use recursive visitor for nodes
    context.registry.addMethodInvocation((node) {
      final s = node.toString();
      if (!s.contains('now()') || code is! LintCode) {
        return;
      }

      if (s.contains('DateTime') || s.contains('clock')) {
        reporter.atNode(node, code as LintCode);
      }
    });
  }
}
