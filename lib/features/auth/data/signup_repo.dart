import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';

class SignupRepo {

  Future<void> signUp({
  required String email,
  required String password,
  required String role, 
  required String username,
  required String phone,
}) async {
  final supabase = Supabase.instance.client;

  final response = await supabase.auth.signUp(
    email: email,
    password: password,
  );

  final user = response.user;
  if (user == null) throw Exception("User creation failed");

  await supabase.from(profileTable).insert({
    'id': user.id,
    'role': role,
    'username': username,
    'phone': phone,
  });
}


}
 