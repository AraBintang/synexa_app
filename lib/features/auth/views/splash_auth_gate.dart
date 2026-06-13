import 'package:flutter/material.dart';

import '../../../services/storage_service.dart';

/// Simple gate: if local session says logged in -> /main
/// else -> /login
class SplashAuthGate extends StatefulWidget {
  const SplashAuthGate({super.key});

  @override
  State<SplashAuthGate> createState() => _SplashAuthGateState();
}

class _SplashAuthGateState extends State<SplashAuthGate> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    final isLoggedIn = await StorageService.getIsLoggedIn();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(isLoggedIn ? '/main' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
