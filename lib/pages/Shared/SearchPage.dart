import 'package:ecommerce_app/controllers/SearchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBarController searchController = Get.put(SearchBarController());

  final TextEditingController searchTextController = TextEditingController();

  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    searchController.loadSearchHistory();
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
          controller: searchTextController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: "Tìm kiếm...",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                final keyword = searchTextController.text;
                if (keyword.isNotEmpty) {
                  searchController.addSearchTerm(keyword);
                  searchController.fetchSuggestions(keyword);
                }
              },
            ),
          ),
          onChanged: (value) {
            searchController.fetchSuggestions(value);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView(
                  children: [
                    if (searchController.searchHistory.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: Text(
                          "Lịch sử tìm kiếm",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ...searchController.searchHistory.map((term) {
                      return ListTile(
                        title: Text(term),
                        onTap: () {
                          searchTextController.text = term;
                          searchController.fetchSuggestions(term);
                        },
                      );
                    }).toList(),
                    if (searchController.suggestions.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          "Đề xuất",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (searchController.isLoading.value)
                      Center(child: CircularProgressIndicator()),
                    ...searchController.suggestions.map((suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () {
                          searchTextController.text = suggestion;
                          searchController.addSearchTerm(suggestion);
                        },
                      );
                    }).toList(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
