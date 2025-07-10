import 'package:flutter/material.dart';
import '../services/auth_storage.dart';

class TokenBasedWidget extends StatefulWidget {
  final Widget child;

  const TokenBasedWidget({super.key, required this.child});

  @override
  TokenBasedWidgetState createState() => TokenBasedWidgetState();
}

class TokenBasedWidgetState extends State<TokenBasedWidget> {
  bool hasToken = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await AuthStorage.getToken();
    setState(() {
      // hasToken = token != null && token.isNotEmpty;
      hasToken = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasToken ? const SizedBox.shrink() : widget.child;
    // if (!hasToken) {
    //   return Center(child: Text("No token found, please log in."));
    // }
    // return widget.child;
  }
}
