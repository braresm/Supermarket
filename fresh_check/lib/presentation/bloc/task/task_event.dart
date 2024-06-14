import 'package:equatable/equatable.dart';
import 'package:fresh_check/domain/models/task.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

// Define concrete Task events

class CompleteTask extends TaskEvent {
  final Task task;

  const CompleteTask(this.task);

  @override
  List<Object> get props => [task];
}
