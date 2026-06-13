import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../services/storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _loading = true);
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // user canceled
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) return;

      // store basic profile (optional)
      // We keep session flag in Hive via StorageService (added below).
      await StorageService.setAuthSession(
        isLoggedIn: true,
        email: user.email ?? '',
        displayName: user.displayName ?? '',
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/main');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: ${e.message ?? e.code}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.lock, size: 40),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Masuk dengan Google',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _loading ? null : _handleGoogleSignIn,
                    icon: const Icon(Icons.login),
                    label: _loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sign in dengan Google'),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Login dengan email & password (akun yang sudah terdaftar).',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty) return 'Email wajib diisi';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final v = value ?? '';
                          if (v.isEmpty) return 'Password wajib diisi';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _loading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  setState(() => _loading = true);
                                  try {
                                    final email = _emailController.text.trim();
                                    final password = _passwordController.text;

                                    final userCredential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );

                                    final user = userCredential.user;
                                    if (user == null) return;

                                    await StorageService.setAuthSession(
                                      isLoggedIn: true,
                                      email: user.email ?? email,
                                      displayName: user.displayName ?? '',
                                    );

                                    if (!mounted) return;
                                    Navigator.of(context).pushReplacementNamed(
                                      '/auth_success',
                                      arguments: {'message': 'Login berhasil'},
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Login gagal: ${e.message ?? e.code}',
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Login gagal: $e'),
                                      ),
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() => _loading = false);
                                    }
                                  }
                                },
                          child: _loading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Masuk'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.of(
                          context,
                        ).pushReplacementNamed('/register'),
                        child: const Text('Belum punya akun? Daftar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
