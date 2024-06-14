import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/models/task.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_bloc.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_state.dart';
import 'package:fresh_check/presentation/bloc/task/task_bloc.dart';
import 'package:fresh_check/presentation/bloc/task/task_event.dart';
import 'package:fresh_check/presentation/bloc/task_list/task_list_bloc.dart';
import 'package:fresh_check/presentation/bloc/task_list/task_list_event.dart';
import 'package:fresh_check/presentation/bloc/task_list/task_list_state.dart';

import '../widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to load tasks
    final authBloc = context.read<AuthBloc>();

    if (authBloc.state is AuthSuccess) {
      int accountId = (authBloc.state as AuthSuccess).account.id;
      context.read<TaskListBloc>().add(ListAccountTasks(accountId));
    }
  }

  void toggleTask(Task task) {
    // Implement task toggling logic here
    context.read<TaskBloc>().add(CompleteTask(task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        String employeeName = 'Employee Name'; // Default value

        if (authState is AuthSuccess) {
          employeeName =
              authState.account.fullname; // Get the name from the account
        }

        return CustomScaffold(
          employeeName: employeeName,
          customColor: const Color(0xFF6F8F72),
          title: 'Home',
          showBackArrow: false,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<TaskListBloc, TaskListState>(
              builder: (context, state) {
                if (state is TaskListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskListLoaded) {
                  return _buildTaskList(state.tasks);
                } else if (state is TaskListError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No tasks available.'));
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFF6F8F72),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Fresh Check\nToday we have some tasks to do:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(
                        decoration: tasks[index].completed
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: tasks[index].completed,
                      onChanged: (bool? value) {
                        setState(() {
                          tasks[index].completed = value!;
                        });
                        toggleTask(tasks[index]);
                      },
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/human_2.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // Add your reminder request functionality here
            },
            icon: Image.asset('assets/homequestion.png', width: 24, height: 24),
            label: const Text('Request a reminder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F8F72),
            ),
          ),
        ),
      ],
    );
  }
}
