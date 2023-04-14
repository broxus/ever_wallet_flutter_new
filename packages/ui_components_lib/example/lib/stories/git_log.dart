import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Page with all colors
class GitLog extends StatefulWidget {
  const GitLog({super.key});

  @override
  State<GitLog> createState() => _GitLogState();
}

class _GitLogState extends State<GitLog> {
  @override
  void initState() {
    super.initState();

    readLogs();
  }

  Future<void> readLogs() async {
    final log = await rootBundle.loadString('assets/git_log.txt');
    setState(() {
      _logs = log;
    });
  }

  String? _logs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Text(_logs ?? ''),
        ),
      ),
    );
  }
}
