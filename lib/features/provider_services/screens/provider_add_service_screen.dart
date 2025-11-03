import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/spacing_widget.dart';
import 'package:taskify/features/bookings/widgets/custom_dotted_border.dart';
import 'package:taskify/features/provider_services/cubit/add_service_cubit.dart';
import 'package:taskify/features/provider_services/cubit/add_service_state.dart';

class ProviderAddServiceScreen extends StatefulWidget {
  ProviderAddServiceScreen({super.key});

  @override
  State<ProviderAddServiceScreen> createState() =>
      _ProviderAddServiceScreenState();
}

class _ProviderAddServiceScreenState extends State<ProviderAddServiceScreen> {
  final formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String? title, description;
  double? price;
  XFile? pickedimg;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'add_service'.tr(),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackTextColor,
            size: 22.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        child: BlocListener<AddServiceCubit, AddServiceState>(
          listener: (context, state) {
            if (state is AddServiceLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                useRootNavigator: true, // ✅ important
                builder:
                    (_) => const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AddServiceSuccess) {
              // ✅ Close the loading dialog safely
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              // ✅ Return to previous screen and signal success
              Navigator.of(context).pop(true);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Service added successfully")),
              );
            } else if (state is AddServiceFailure) {
              // ✅ Close loading if it’s still open
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: SizedBox(
            height: size.height,
            child: Form(
              key: formKey,
              autovalidateMode:
                  _submitted
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeightSpace(12),
                          Text(
                            "service_name".tr(),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          HeightSpace(8),

                          CustomTextFormField(
                            hintText: "service_name".tr(),
                            prefixIcon: Icons.build,
                            onChanged: (value) => title = value,
                          ),

                          HeightSpace(12),
                          Text(
                            "Description".tr(),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          HeightSpace(8),
                          CustomTextFormField(
                            maxLines: 4,
                            onChanged: (value) => description = value,
                          ),
                          HeightSpace(12),
                          Text(
                            "price".tr(),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                          HeightSpace(8),
                          CustomTextFormField(
                            hintText: "price".tr(),
                            prefixIcon: Icons.attach_money,
                            onChanged:
                                (value) => price = double.tryParse(value),
                            keyboardType: TextInputType.number,
                          ),
                          HeightSpace(12),
                          Text(
                            'service_photo'.tr(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),

                          HeightSpace(8),
                          SizedBox(
                            height: 250,
                            child: GestureDetector(
                              onTap: () async {
                                final XFile? pickedFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);

                                if (pickedFile == null) return;

                                setState(() {
                                  pickedimg = pickedFile;
                                });
                              },
                              child:
                                  pickedimg == null
                                      ? CustomDottedBorder(
                                        children: [
                                          Text(
                                            "upload_media".tr(),
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text("upload_note".tr()),
                                        ],
                                      )
                                      : Image.file(File(pickedimg!.path)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'save_Service'.tr(),
                    size: Size(size.width.w, 48.h),
                    color: AppColors.primaryColor,
                    fontColor: AppColors.whiteTextColor,
                    onPressed: () {
                      setState(() => _submitted = true);
                      if (formKey.currentState!.validate()) {
                        context.read<AddServiceCubit>().addService(
                          title: title!,
                          description: description!,
                          price: price!,
                          photo: File(pickedimg!.path),
                        );
                      }
                    },
                  ),
                  HeightSpace(16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
