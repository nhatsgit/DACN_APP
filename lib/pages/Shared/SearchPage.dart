import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode(); // FocusNode để điều khiển focus
  List<String> searchHistory = [];
  List<String> suggestions = [
    'Product 1',
    'Product 2',
    'Product 3'
  ]; // Example suggestions

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
    // Tự động focus vào TextField khi trang được mở
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  // Load search history from SharedPreferences
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('search_history') ?? [];
    });
  }

  // Save search history to SharedPreferences
  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    if (searchHistory.length > 10) {
      searchHistory.removeAt(0); // Remove the oldest search
    }
    await prefs.setStringList('search_history', searchHistory);
  }

  // Add new search term and update history
  void _addSearchTerm(String term) {
    setState(() {
      searchHistory.insert(
          0, term); // Insert the new search term at the beginning
    });
    _saveSearchHistory(); // Save updated history
  }

  // Handle search when button is clicked
  void _onSearch() {
    if (searchController.text.isNotEmpty) {
      _addSearchTerm(searchController.text);
      searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: searchController,
          focusNode: focusNode, // Gắn FocusNode vào TextField
          decoration: InputDecoration(
            hintText: "Tìm kiếm...",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: _onSearch,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Lịch sử tìm kiếm
            Expanded(
              child: ListView(
                children: [
                  if (searchHistory.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      child: Text(
                        "Lịch sử tìm kiếm",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ...searchHistory.map((term) {
                    return ListTile(
                      title: Text(term),
                      onTap: () {
                        searchController.text = term;
                        _onSearch();
                      },
                    );
                  }).toList(),

                  // Đề xuất tìm kiếm
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      "Đề xuất",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...suggestions.map((suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        searchController.text = suggestion;
                        _onSearch();
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
