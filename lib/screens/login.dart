import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:split_frontend/config/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final client = Supabase.instance.client;

class LoginScreen extends StatelessWidget {
  final EnvConfig cfg;
  const LoginScreen(this.cfg, {super.key});

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

  String buildRedirectUrl() {
    if (kIsWeb) {
      return "${cfg.splitrBackendUrl}/login-callback";
    } else {
      return 'splitapp://login-callback/';
    }
  }
}
