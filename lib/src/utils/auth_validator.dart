import 'package:flutter/material.dart';
import '../services/auth_storage.dart';

class TokenBasedWidget extends StatefulWidget {
  final Widget child;

  const TokenBasedWidget({super.key, required this.child});

  @override
  _TokenBasedWidgetState createState() => _TokenBasedWidgetState();
}

class _TokenBasedWidgetState extends State<TokenBasedWidget> {
  bool hasToken = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await AuthStorage.getToken();
    setState(() {
      hasToken = token != null && token.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasToken) {
      return Center(child: Text("No token found, please log in."));
    }
    return widget.child;
  }
}
