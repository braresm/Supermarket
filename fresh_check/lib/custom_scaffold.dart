import 'package:flutter/material.dart';
import 'presentation/widgets/dropdown_menu.dart';

class CustomScaffold extends StatefulWidget {
  final String employeeName;
  final Widget body;
  final Color customColor;
  final String title;
  final bool showBackArrow;

  const CustomScaffold({
    Key? key,
    required this.employeeName,
    required this.body,
    required this.customColor,
    required this.title,
    this.showBackArrow = true,
  }) : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool _isMenuVisible = false;

  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.customColor,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: _toggleMenu,
          ),
        ],
      ),
      body: Stack(
        children: [
          widget.body,
          if (_isMenuVisible)
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: CustomDropdownMenu(employeeName: widget.employeeName),
            ),
        ],
      ),
    );
  }
}
