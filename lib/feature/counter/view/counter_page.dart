import 'package:app/feature/counter/counter.dart';
import 'package:app/feature/counter/cubit/log_display_cubit.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => LogDisplayCubit(),
        ),
      ],
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.welcomeTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: LogDisplay(),
              ),
            ),
            const Center(child: CounterText()),
            TextButton(
              onPressed: () => context.read<CounterCubit>().logs(),
              child: const Text('Logs from dart'),
            ),
            TextButton(
              onPressed: () => context.read<CounterCubit>().nekotonLogs(),
              child: const Text('Logs from rust'),
            ),
            TextButton(
              onPressed: () => context.read<CounterCubit>().nekotonPanic(),
              child: const Text('Panic from rust'),
            ),
            TextButton(
              onPressed: () => context.read<CounterCubit>().dartError(),
              child: const Text('Dart error'),
            ),
            TextButton(
              onPressed: () => context.read<CounterCubit>().dartException(),
              child: const Text('Dart exception'),
            ),
            TextButton(
              onPressed: () => context.read<LogDisplayCubit>().requestLogs(),
              child: const Text('Request logs from db'),
            ),
            TextButton(
              onPressed: () =>
                  context.read<LogDisplayCubit>().writeAllLogsToJson(),
              child: const Text('Write logs to acrhived json'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().getFromNekoton(),
            child: const Icon(Icons.api),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().getFromService(),
            child: const Icon(Icons.computer),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().getFromNekotonRust(),
            child: const Icon(Icons.pedal_bike),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displaySmall);
  }
}

class LogDisplay extends StatelessWidget {
  const LogDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logs = context.select((LogDisplayCubit cubit) => cubit.state);
    return Text(logs, style: theme.textTheme.bodyMedium);
  }
}
