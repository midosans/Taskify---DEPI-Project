import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/provider_home/widgets/custom_list_tile_for_provider.dart';

class ProviderHomeScreen extends StatelessWidget {
  ProviderHomeScreen({super.key});
  final List<BookingModel> bookingListAccept = [
    BookingModel(
      id: "b001",
      userId: "u001",
      serviceId: "s001",
      vendorId: "v001",
      serviceImage: "assets/pngs/House_cleaning_example.png",
      serviceName: "House Cleaning",
      vendorName: "Sarah Miller",
      userName: "John Doe",
      price: 50.0,
      bookingDate: DateTime(2025, 7, 15, 10, 0),
      status: "pending",
      address: "123 Maple Street",
    ),
    BookingModel(
      id: "b002",
      userId: "u002",
      serviceId: "s002",
      vendorId: "v002",
      serviceImage: "assets/pngs/Plumbing_example.png",
      serviceName: "Plumbing",
      vendorName: "David Lee",
      userName: "Emma Johnson",
      price: 75.5,
      bookingDate: DateTime(2025, 7, 16, 14, 0),
      status: "pending",
      address: "456 Oak Avenue",
    ),
    BookingModel(
      id: "b003",
      userId: "u003",
      serviceId: "s003",
      vendorId: "v003",
      serviceImage: "assets/pngs/Elecrtrical_repair_example.png",
      serviceName: "Electrical Repair",
      vendorName: "Emily Chen",
      userName: "Michael Smith",
      price: 90.0,
      bookingDate: DateTime(2025, 7, 17, 11, 0),
      status: "pending",
      address: "789 Pine Lane",
    ),
  ];

    final List<BookingModel> bookingListOngoing = [
    BookingModel(
      id: "b001",
      userId: "u001",
      serviceId: "s001",
      vendorId: "v001",
      serviceImage: "assets/pngs/House_cleaning_example.png",
      serviceName: "House Cleaning",
      vendorName: "Sarah Miller",
      userName: "John Doe",
      price: 50.0,
      bookingDate: DateTime(2025, 7, 15, 10, 0),
      status: "accepted",
      address: "123 Maple Street",
    ),
    BookingModel(
      id: "b002",
      userId: "u002",
      serviceId: "s002",
      vendorId: "v002",
      serviceImage: "assets/pngs/Plumbing_example.png",
      serviceName: "Plumbing",
      vendorName: "David Lee",
      userName: "Emma Johnson",
      price: 75.5,
      bookingDate: DateTime(2025, 7, 16, 14, 0),
      status: "accepted",
      address: "456 Oak Avenue",
    ),
    BookingModel(
      id: "b003",
      userId: "u003",
      serviceId: "s003",
      vendorId: "v003",
      serviceImage: "assets/pngs/Elecrtrical_repair_example.png",
      serviceName: "Electrical Repair",
      vendorName: "Emily Chen",
      userName: "Michael Smith",
      price: 90.0,
      bookingDate: DateTime(2025, 7, 17, 11, 0),
      status: "accepted",
      address: "789 Pine Lane",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'Taskify',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
           SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "new_orders".tr(),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CustomListTileForProvider(service: bookingListAccept[index]);
            }, childCount: bookingListAccept.length),
          ),

           SliverToBoxAdapter(child: SizedBox(height: 16.h)),

           SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "ongoing_work".tr(),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CustomListTileForProvider(service: bookingListOngoing[index]);
            }, childCount: bookingListOngoing.length),
          ),
        ],
      ),
    );
  }
}
