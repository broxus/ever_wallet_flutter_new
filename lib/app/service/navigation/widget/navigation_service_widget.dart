import 'package:app/app/service/navigation/bloc/navigation_bloc.dart';
import 'package:app/app/service/service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationServiceWidget extends StatefulWidget {
  const NavigationServiceWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<NavigationServiceWidget> createState() =>
      _NavigationServiceWidgetState();
}

class _NavigationServiceWidgetState extends State<NavigationServiceWidget> {
  final NavigationBloc _bloc = NavigationBloc();

  @override
  void initState() {
    super.initState();

    _bloc.init();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onNavigationEvent(NavigationState state) {
    _onLocationChange(state.oldState, state.state);
  }

  // Handle location change
  void _onLocationChange(
    NavigationServiceState? oldState,
    NavigationServiceState? state,
  ) {
    // Handle every location change
    switch ((oldState, state)) {
      // Skip if location is not yet set
      case (_, null):
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      bloc: _bloc,
      listener: (context, state) => _onNavigationEvent(state),
      child: widget.child,
    );
  }
}
