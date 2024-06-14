import 'package:equatable/equatable.dart';

class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

// Define concrete Task states

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskCompleted extends TaskState {}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
