import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final client = Supabase.instance.client;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () {
            client.auth.signInWithOAuth(
              Provider.google,
              redirectTo: buildRedirectUrl(),
            );
          },
          child: const Text("Login")),
    );
  }
}

String buildRedirectUrl() {
  if (kIsWeb) {
    return "http://localhost:3000/login-callback";
  } else {
    return 'splitapp://login-callback/';
  }
}
