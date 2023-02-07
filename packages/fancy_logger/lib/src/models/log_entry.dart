import 'package:equatable/equatable.dart';

/// {@template pog_entry}
/// An object which represents a log entry
/// {@pog_entry}
class LogEntry extends Equatable {
  /// {@macro pog_entry}
  const LogEntry({required this.id});

  /// The model's id.
  final int id;

  @override
  List<Object> get props => [id];
}
