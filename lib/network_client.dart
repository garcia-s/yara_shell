import 'package:flutter/material.dart';
import 'package:nm/nm.dart';

class NetworkClientProvider extends ChangeNotifier {
  final manager = NetworkManagerClient();
  NetworkClientProvider() {}

  Future<void> _init() async {
    await manager.connect();
  }
}
