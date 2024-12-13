import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yara_shell/menu/parser.dart';
import 'package:yara_shell/provider.dart';

class SearchListWidget extends StatefulWidget {
  const SearchListWidget({super.key});
  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class AppDescription {
  final String name;
  final String icon;
  final String command;

  AppDescription({
    required this.name,
    required this.icon,
    required this.command,
  });
}

class _SearchListWidgetState extends State<SearchListWidget> {
  // List of items to search through
  List<AppDescription>? items;

  // List to hold the filtered items
  List<AppDescription> filteredItems = [];

  // Controller for the search field
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getAppList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Method to filter the list based on the search query
  void filterList(String str) {
    if (items == null) return;
    setState(() {
      filteredItems = items!
          .where(
            (item) => item.name.toLowerCase().contains(
                  str.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  Future<void> getAppList() async {
    final apps = await getApplications();
    setState(() {
      items = apps;
      filteredItems = items!;
    });
  }

  Future<void> launchApp(int index) async {
    final command = filteredItems[index].command.split(" ");
    await Process.run(
      command[0],
      command.skip(1).toList(),
      runInShell: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.fromView(
      view: View.of(context),
      child: Container(
        color: Colors.black38,
        child: Center(
          child: SizedBox(
            width: 500,
            height: 500,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    title: const Text('Applications'),
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: true,
                          onChanged: (str) => filterList(str),
                          onSubmitted: (str) {
                            if (filteredItems.isNotEmpty) {
                              ShellProvider.of(context).closeAll();
                              launchApp(0);
                            }
                          },
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
                              title: Text(filteredItems[index].name),
                              onTap: () => launchApp(index),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
