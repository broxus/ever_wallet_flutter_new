import 'package:equatable/equatable.dart';

/// {@template example_model}
/// An object which represents an example model.
/// {@endtemplate}
class ExampleModel extends Equatable {
  /// {@macro example_model}
  const ExampleModel({required this.id});

  /// The model's id.
  final int id;

  @override
  List<Object> get props => [id];
}
