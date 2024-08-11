import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const LayoutWidget({
    super.key,
    required this.child,
    this.title="home",
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: actions,
      ),
      body: Container(
        child: child,
      ),
      floatingActionButton: floatingActionButton,
    );
  }

}
