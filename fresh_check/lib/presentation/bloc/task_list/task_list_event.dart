import 'package:equatable/equatable.dart';

class TaskListEvent extends Equatable {
  const TaskListEvent();

  @override
  List<Object> get props => [];
}

// Define concrete TaskList events

class ListAccountTasks extends TaskListEvent {
  final int accountId;

  const ListAccountTasks(this.accountId);

  @override
  List<Object> get props => [accountId];
}
