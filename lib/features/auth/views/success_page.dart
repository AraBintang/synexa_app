import 'package:flutter/material.dart';

import '../../../shared/widgets/success_overlay.dart';

class SuccessPage extends StatefulWidget {
  final String message;

  const SuccessPage({super.key, this.message = 'Berhasil'});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();
    // jeda agar pengguna sempat membaca pesan
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false);
    });

    // fallback: jika navigasi delay tidak sempat terjadi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // no-op, hanya memastikan build terpanggil
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SuccessOverlay(message: widget.message)),
    );
  }
}
