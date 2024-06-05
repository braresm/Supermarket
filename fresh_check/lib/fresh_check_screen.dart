import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fresh_check_product_screen.dart';

class FreshCheckScreen extends StatefulWidget {
  @override
  _FreshCheckScreenState createState() => _FreshCheckScreenState();
}

class _FreshCheckScreenState extends State<FreshCheckScreen> {
  List<dynamic> categories = [];
  List<dynamic> tasks = [];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final String response = await rootBundle.loadString('assets/tasks.json');
    final data = await json.decode(response);
    setState(() {
      categories = data['categories'];
      if (categories.isNotEmpty) {
        selectedCategory = categories[0]['name'];
        tasks = categories[0]['tasks'];
      }
    });
  }

  void onCategoryChanged(String? newCategory) {
    setState(() {
      selectedCategory = newCategory!;
      tasks = categories.firstWhere((category) => category['name'] == selectedCategory)['tasks'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8; // 80% of the screen width

    return Scaffold(
      appBar: AppBar(
        title: Text('Fresh Check'),
        backgroundColor: Color(0xFF6F8F72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Fresh check',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: cardWidth, // Fixed width for dropdown container
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFAED3A4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: categories.map<DropdownMenuItem<String>>((category) {
                    return DropdownMenuItem<String>(
                      value: category['name'],
                      child: Text(category['name']),
                    );
                  }).toList(),
                  onChanged: onCategoryChanged,
                  value: selectedCategory,
                  style: TextStyle(color: Colors.white),
                  dropdownColor: Color(0xFF6F8F72),
                ),
              ),
              SizedBox(height: 20),
              ...tasks.map((task) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FreshCheckProductScreen(task: task)),
                  );
                },
                child: TaskCard(task: task, width: cardWidth),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final dynamic task;
  final double width;

  TaskCard({required this.task, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFAED3A4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['task'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              task['description'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
