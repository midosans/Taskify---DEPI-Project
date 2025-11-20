import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/app_services/dialog_extension.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/core/widgets/spacing_widget.dart';
import 'package:taskify/features/provider_services/cubit/update_service_cubit.dart';
import 'package:taskify/features/provider_services/cubit/update_service_state.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';

class ProviderUpdateServiceScreen extends StatefulWidget {
  final ProviderServicesModel servicesModel;
  ProviderUpdateServiceScreen({super.key, required this.servicesModel});

  @override
  State<ProviderUpdateServiceScreen> createState() =>
      _ProviderUpdateServiceScreenState();
}

class _ProviderUpdateServiceScreenState
    extends State<ProviderUpdateServiceScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _submitted = false;
  String? title, description;
  double? price;
  XFile? pickedimg;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.servicesModel.title!;
    descController.text = widget.servicesModel.description!;
    priceController.text = widget.servicesModel.price!.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateServiceCubit>();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'update_service'.tr(),
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
        child: BlocListener<UpdateServiceCubit, UpdateServiceState>(
          listener: (context, state) async {
            if (state is UpdateServiceLoading) {
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
            } else if (state is UpdateServiceSuccess) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (!context.mounted) return;

              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (_) => CustomNotifyDialog(
                      title: "Service Updated",
                      subtitle: "Your service has been updated successfully.",
                      buttontext: "OK",
                      icon: Icons.check_circle,
                    ),
              ).then((_) {
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    providerServicesScreenRoute,
                    (route) => false,
                  );
                }
              });
            } else if (state is UpdateServiceFailure) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (!context.mounted) return;

              showDialog(
                context: context,
                builder:
                    (_) => CustomNotifyDialog(
                      title: "Error",
                      subtitle: state.errorMessage,
                      buttontext: "OK",
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
                            // onChanged: (value) => title = value,
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
                            controller: descController,
                            maxLines: 4,
                            // onChanged: (value) => description = value,
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
                            // onChanged:
                            //     (value) => price = double.tryParse(value),
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
                                      ? CustomCashedImage(
                                        url: widget.servicesModel.photo!,
                                        size: Size(double.infinity, 168.h),
                                      )
                                      : Image.file(File(pickedimg!.path)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'update_Service'.tr(),
                    size: Size(size.width.w, 48.h),
                    color: AppColors.primaryColor,
                    fontColor: AppColors.whiteTextColor,
                    onPressed: () {
                      setState(() => _submitted = true);
                      if (formKey.currentState!.validate()) {
                        context.showBlocDialog(
                          cubit: cubit,
                          dialog: CustomConfirmDialog(
                            title: "Edit Service",
                            subtitle: "Are you sure you want to update?",
                            buttontext: "Edit",
                            onConfirm: () {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop(); // closes the dialog
                              cubit.updateService(
                                id: widget.servicesModel.id!,
                                title: nameController.text.trim(),
                                description: descController.text.trim(),
                                price: double.parse(priceController.text),
                                photo:
                                    pickedimg != null
                                        ? File(pickedimg!.path)
                                        : null,
                              );
                            },
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
