import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/models/task.dart';
import 'package:fresh_check/domain/usecases/list_account_tasks.dart';
import 'package:fresh_check/presentation/bloc/task_list/task_list_event.dart';
import 'package:fresh_check/presentation/bloc/task_list/task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final ListAccountTasksUseCase listAccountTasksUseCase;

  TaskListBloc({required this.listAccountTasksUseCase})
      : super(TaskListInitial()) {
    on<ListAccountTasks>(_onListAccountTasks);
  }

  Future<void> _onListAccountTasks(
      ListAccountTasks event, Emitter<TaskListState> emit) async {
    emit(TaskListLoading());
    try {
      List<Task> tasks = await listAccountTasksUseCase(event.accountId);

      emit(TaskListLoaded(tasks));
    } catch (e) {
      emit(TaskListError(e.toString()));
    }
  }
}
