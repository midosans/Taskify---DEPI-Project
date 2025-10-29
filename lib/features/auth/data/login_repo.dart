import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class LoginRepo {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) throw Exception("Invalid login credentials");

    final data = await supabase
        .from(profileTable)
        .select()
        .eq('id', user.id)
        .maybeSingle();

    return data; 
  }
}
