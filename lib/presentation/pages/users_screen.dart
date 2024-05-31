import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:utor_technical_round/domain/models/user.dart';
import 'package:utor_technical_round/presentation/controllers/users_controller.dart';
import 'package:utor_technical_round/presentation/pages/user_posts_screen.dart';
import 'package:utor_technical_round/utils/resources/random_color_generator.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usersController = Get.put(UsersController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Users"),
      ),
      body: Obx(
        () => usersController.isLoadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: usersController.users.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 35.h),
                itemBuilder: (context, index) {
                  User user = usersController.users[index];
                  return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => UserPostsScreen(user: user),
                          arguments: {'userId': user.id},
                        );
                      },
                      child: UserWidget(user: user));
                },
              ),
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: getRandomColor(),
          child: Center(
            child: Text(
              user.name?[0] ?? "!",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        title: Text(
          user.name ?? "No name specified",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          user.email?.toLowerCase() ?? "No email mentioned",
        ),
      ),
    )
        .animate(delay: const Duration(milliseconds: 300))
        .fadeIn(duration: const Duration(milliseconds: 240));
  }
}
