import 'package:flutter/material.dart';

class SearchListWidget extends StatefulWidget {
  const SearchListWidget({super.key});
  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  // List of items to search through
  final List<String> items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew'
  ];

  // List to hold the filtered items
  List<String> filteredItems = [];

  // Controller for the search field
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items;
    searchController.addListener(() {
      filterList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method to filter the list based on the search query
  void filterList() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredItems =
          items.where((item) => item.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (_) {
                  print("Text Changed");
                },
                focusNode: FocusNode(
                  onKey: (_, e) {
                    print(
                      "Onkey Fired ${e.logicalKey.keyLabel} ${e.physicalKey.debugName}",
                    );
                    return KeyEventResult.ignored;
                  },
                  onKeyEvent: (_, e) {
                    print(
                      "OnkeyEvent Fired ${e.logicalKey.keyLabel} ${e.physicalKey.}",
                    );
                    return KeyEventResult.ignored;
                  },
                ),
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
