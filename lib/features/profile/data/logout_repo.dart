import 'package:supabase_flutter/supabase_flutter.dart';

class LogoutRepo {
  final SupabaseClient _client = Supabase.instance.client;
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}