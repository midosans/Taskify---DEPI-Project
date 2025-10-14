import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/screens/bookings_tab.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  List<BookingModel> bookingList = [
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
      status: "completed",
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
      status: "cancelled",
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
      status: "upcoming",
      address: "789 Pine Lane",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'bookings'.tr(),
            style: TextStyle(
              color: AppColors.blackTextColor,
              fontSize: 23.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          bottom: TabBar(
            labelColor: AppColors.blackTextColor,
            labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            unselectedLabelColor: AppColors.lightprimarycolor,
            indicatorColor: AppColors.blackTextColor,
            indicatorWeight: 1,
            tabs: [
              Tab(text: 'all'.tr()),
              Tab(text: 'completed'.tr()),
              Tab(text: 'upcoming'.tr()),
              Tab(text: 'cancelled'.tr()),
            ],
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Center(child: AllBookingsTab(bookings: bookingList)),
             Center(child: AllBookingsTab(bookings: bookingList)),
             Center(child: AllBookingsTab(bookings: bookingList)),
             Center(child: AllBookingsTab(bookings: bookingList)),
          ],
        ),
      ),
    );
  }
}
