import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final String response = await rootBundle.loadString('assets/tasks_home.json');
    final data = await json.decode(response);
    setState(() {
      tasks = data;
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      employeeName: 'Employee Name',
      customColor: Color(0xFF6F8F72),
      title: 'Home',
      showBackArrow: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF6F8F72),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Fresh Check\nToday we have some tasks to do:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          tasks[index]['task'],
                          style: TextStyle(
                            decoration: tasks[index]['done'] ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: tasks[index]['done'],
                          onChanged: (bool? value) {
                            toggleTask(index);
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
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add your reminder request functionality here
                },
                icon: Image.asset('assets/homequestion.png', width: 24, height: 24),
                label: Text('Request a reminder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6F8F72),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
