import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:taskify/core/app_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final accentColor = AppColors.primaryColor;
    final secondaryColor = AppColors.secondaryColor;
    final background = AppColors.backgroundColor;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'contact_us'.tr(),
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 38),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: background,
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.04),
                            spreadRadius: 4,
                            blurRadius: 22,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 60, 22, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Contact Info
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: secondaryColor.withOpacity(0.07),
                                    blurRadius: 7,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _contactRow(
                                    Icons.phone,
                                    'contact_phone'.tr(),
                                    accentColor,
                                  ),
                                  const SizedBox(height: 10),
                                  _contactRow(
                                    Icons.email,
                                    'contact_email'.tr(),
                                    accentColor,
                                  ),
                                  const SizedBox(height: 10),
                                  _contactRow(
                                    Icons.location_on,
                                    'contact_address'.tr(),
                                    secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Form
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _textField(
                                          controller: nameController,
                                          hint: 'contact_name_hint'.tr(),
                                          icon: Icons.person_outline,
                                          iconColor: accentColor,
                                          validator:
                                              (v) =>
                                                  v!.isEmpty
                                                      ? 'Required'.tr()
                                                      : null,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _textField(
                                          controller: emailController,
                                          hint: 'contact_email_hint'.tr(),
                                          icon: Icons.email_outlined,
                                          iconColor: accentColor,
                                          validator:
                                              (v) =>
                                                  v!.isEmpty
                                                      ? 'Required'.tr()
                                                      : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  _textField(
                                    controller: messageController,
                                    hint: 'contact_message_hint'.tr(),
                                    icon: Icons.message,
                                    iconColor: secondaryColor,
                                    maxLines: 3,
                                    validator:
                                        (v) =>
                                            v!.isEmpty ? 'Required'.tr() : null,
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: accentColor,
                                        elevation: 5,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        shadowColor: accentColor.withOpacity(
                                          0.3,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'contact_success'.tr(),
                                              ),
                                            ),
                                          );
                                          nameController.clear();
                                          emailController.clear();
                                          messageController.clear();
                                        }
                                      },
                                      child: Text(
                                        'contact_send_button'.tr(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 120,
                        height: 100,
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(80),
                            bottomLeft: Radius.circular(55),
                          ),
                          gradient: LinearGradient(
                            colors: [accentColor, secondaryColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const SizedBox(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                // Header outside card
                Text(
                  'contact_us'.tr(),
                  style: TextStyle(
                    fontSize: 27,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String text, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.blackTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: TextStyle(color: AppColors.blackTextColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor),
          filled: true,
          fillColor: AppColors.whiteTextColor,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.hintTextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
