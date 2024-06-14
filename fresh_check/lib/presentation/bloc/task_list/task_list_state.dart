import 'package:equatable/equatable.dart';
import 'package:fresh_check/domain/models/task.dart';

class TaskListState extends Equatable {
  const TaskListState();

  @override
  List<Object?> get props => [];
}

// Define concrete TaskList states

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListLoaded extends TaskListState {
  final List<Task> tasks;

  const TaskListLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskListError extends TaskListState {
  final String message;

  const TaskListError(this.message);

  @override
  List<Object?> get props => [message];
}
