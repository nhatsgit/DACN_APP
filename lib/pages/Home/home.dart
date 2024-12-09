import 'package:ecommerce_app/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  void _onCartPressed() {}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomAppBar(children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]),
          SingleChildScrollView(
            child: Column(
              children: [Text("mycarts")],
            ),
          )
        ],
      ),
    );
  }
}
