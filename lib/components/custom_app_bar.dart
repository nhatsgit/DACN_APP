import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final List<Widget> children;
  const CustomAppBar({Key? key, required this.children}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 75,
      color: Colors.blueAccent,
      child: Row(
        children: [
          ...widget.children,
        ],
      ),
    );
  }
}
