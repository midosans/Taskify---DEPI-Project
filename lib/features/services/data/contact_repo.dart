import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/features/services/data/contact_model.dart';

class ContactRepo {
  Future<ContactModel?> getPhone(String providerId) async {
    final supabase = Supabase.instance.client;

    final result =
        await supabase
            .from(profileTable)
            .select('phone, avatar')
            .eq('id', providerId)
            .maybeSingle();

    if (result == null) return null;
    final contact = ContactModel.fromJson(result);

    if (contact.phone.trim().isEmpty) return null;
    if (contact.avatar?.trim().isEmpty ?? true) return null;

    return contact;
  }
}
