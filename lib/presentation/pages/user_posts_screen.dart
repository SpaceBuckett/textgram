import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:utor_technical_round/domain/models/post.dart';
import 'package:utor_technical_round/domain/models/user.dart';
import 'package:utor_technical_round/presentation/controllers/user_posts_controller.dart';
import 'package:utor_technical_round/presentation/pages/post_details_screen.dart';
import 'package:utor_technical_round/presentation/widgets/post_widget.dart';

class UserPostsScreen extends StatelessWidget {
  UserPostsScreen({
    required this.user,
    super.key,
  });

  final User user;
  final userPostsController = Get.put(UserPostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name}'s all posts"),
      ),
      body: Obx(
        () => userPostsController.isLoadingData.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 35.h),
                itemCount: userPostsController.posts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Post post = userPostsController.posts[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => PostDetails(
                          user: user,
                          post: post,
                        ),
                        arguments: {'postId': post.id},
                      );
                    },
                    child: PostWidget(post: post),
                  );
                },
              ),
      ),
    );
  }
}
