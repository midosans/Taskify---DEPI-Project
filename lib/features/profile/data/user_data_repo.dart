
import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/features/profile/data/user_data_model.dart';

class UserDataRepo{
  final SupabaseClient _supabase = Supabase.instance.client;
  Future <UserdataModel> getUserData(String userId) async {
  final response =await _supabase.from('profile').select().eq('id', userId).maybeSingle();
  log('===============$response=================');
  if(response == null){
    throw Exception('User not found');
  }else{
    return UserdataModel.fromJson(response);
  }
  }
}