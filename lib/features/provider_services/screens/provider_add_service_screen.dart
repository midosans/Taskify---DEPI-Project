import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/app_services/dialog_extension.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/core/widgets/spacing_widget.dart';
import 'package:taskify/core/widgets/custom_dotted_border.dart';
import 'package:taskify/features/provider_services/cubit/add_service_cubit.dart';
import 'package:taskify/features/provider_services/cubit/add_service_state.dart';

class ProviderAddServiceScreen extends StatefulWidget {
  const ProviderAddServiceScreen({super.key});

  @override
  State<ProviderAddServiceScreen> createState() =>
      _ProviderAddServiceScreenState();
}

class _ProviderAddServiceScreenState extends State<ProviderAddServiceScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _submitted = false;
  XFile? pickedimg;

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cubit = context.read<AddServiceCubit>();

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
          onPressed: () => Navigator.of(context).pop(false), // returns false
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        child: BlocListener<AddServiceCubit, AddServiceState>(
          listener: (context, state) async {
            if (state is AddServiceLoading) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              showDialog(
                context: context,
                barrierDismissible: false,
                useRootNavigator: true,
                builder:
                    (_) => const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AddServiceSuccess) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (!context.mounted) return;

              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (_) => CustomNotifyDialog(
                      title: "service_added_title".tr(),
                      subtitle: "service_added_subtitle".tr(),
                      buttontext: "ok".tr(),
                      icon: Icons.check_circle,
                    ),
              ).then((_) {
                if (context.mounted) {
                  Navigator.of(context).pop(true);
                }
              });
            } else if (state is AddServiceFailure) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (!context.mounted) return;

              showDialog(
                context: context,
                builder:
                    (_) => CustomNotifyDialog(
                      title: "error_title".tr(),
                      subtitle:
                          state
                              .errorMessage, 
                      buttontext: "ok".tr(),
                      icon: Icons.error,
                    ),
              );
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
                            controller: nameController,
                            prefixIcon: Icons.build,
                          ),
                          HeightSpace(12),
                          Text(
                            "description".tr(),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          HeightSpace(8),
                          CustomTextFormField(
                            maxLines: 4,
                            controller: descController,
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
                            controller: priceController,
                            prefixIcon: Icons.attach_money,
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

                                setState(() => pickedimg = pickedFile);
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
                      if (formKey.currentState!.validate() &&
                          pickedimg != null) {
                        context.showBlocDialog(
                          cubit: cubit,
                          dialog: CustomConfirmDialog(
                            title: "add_service_title".tr(),
                            subtitle: "add_service_subtitle".tr(
                              args: [nameController.text],
                            ),
                            buttontext: "add".tr(),
                            onConfirm: () {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop(); // closes the dialog

                              context.read<AddServiceCubit>().addService(
                                title: nameController.text,
                                description: descController.text,
                                price: double.parse(priceController.text),
                                photo: File(pickedimg!.path),
                              );
                            },
                          ),
                        );
                      } else if (pickedimg == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("please_select_photo".tr()),
                            backgroundColor: Colors.orange,
                          ),
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
