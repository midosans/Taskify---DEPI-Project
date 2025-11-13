import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

/// Verify Code Screen
///
/// This screen allows users to enter the OTP (One-Time Password) or
/// verification code that was sent to their email address. The code
/// is used to verify the user's identity before allowing them to reset
/// their password.
class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String _getVerificationCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: PageHeading(title: 'verify_code'.tr()),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'verify_code_description'.tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.greyTextColor,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              widget.email,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // OTP input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => SizedBox(
                            width: 45.w,
                            height: 55.h,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.whiteTextColor,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.lightprimarycolor,
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.lightprimarycolor,
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 2.w,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onChanged:
                                  (value) => _onCodeChanged(index, value),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Resend code option
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'didnt_receive_code'.tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.greyTextColor,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: () {
                                // TODO: Implement resend code functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('code_resent'.tr()),
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                );
                              },
                              child: Text(
                                'resend_code'.tr(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: 'verify'.tr(),
                        size: Size(size.width.w, 48.h),
                        color: AppColors.primaryColor,
                        fontColor: AppColors.whiteTextColor,
                        onPressed: () {
                          final code = _getVerificationCode();
                          if (code.length == 6) {
                            // Navigate to reset password screen
                            Navigator.pushNamed(
                              context,
                              resetPasswordScreenRoute,
                              arguments: {'email': widget.email, 'code': code},
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'please_enter_complete_code'.tr(),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Back to forgot password link
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'back_to_forgot_password'.tr(),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
