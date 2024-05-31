import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:utor_technical_round/domain/models/comment.dart';
import 'package:utor_technical_round/domain/models/post.dart';
import 'package:utor_technical_round/domain/models/user.dart';
import 'package:utor_technical_round/presentation/controllers/post_details_controller.dart';
import 'package:utor_technical_round/utils/resources/random_color_generator.dart';

class PostDetails extends StatelessWidget {
  PostDetails({
    required this.post,
    required this.user,
    super.key,
  });

  final User user;
  final Post post;
  final postDetailsController = Get.put(PostDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              SizedBox(height: 25.h),
              PostDetailsContainer(
                user: user,
                post: post,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: const Divider(),
              ),
              Obx(
                () => postDetailsController.isLoadingComments.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (postDetailsController.comments.isNotEmpty) ...[
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 15.0.h, left: 15.w),
                              child: const Text('Comments'),
                            ),
                          ],
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: postDetailsController.comments.length,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                commentDetails:
                                    postDetailsController.comments[index],
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.commentDetails,
  });

  final Comment commentDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InitialAvatarWithName(
            name: commentDetails.name,
            showTheTimePassed: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0.w),
            child: Text(
              getTextWithoutNewLine(
                commentDetails.body ?? "",
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTextWithoutNewLine(String commentBody) {
    return commentBody.replaceAll('\n', '');
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 55.0.h),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}

class PostDetailsContainer extends StatelessWidget {
  const PostDetailsContainer({
    required this.post,
    required this.user,
    super.key,
  });
  final User user;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InitialAvatarWithName(
            name: user.name,
            showTheTimePassed: true,
          ),
          SizedBox(height: 3.h),
          Text(
            post.title ?? "No Title",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            post.body?.replaceAll('\n', '') ??
                "Nothing mentioned in the body...",
          ),
        ],
      ),
    );
  }
}

class InitialAvatarWithName extends StatelessWidget {
  const InitialAvatarWithName({
    required this.name,
    required this.showTheTimePassed,
    super.key,
  });

  final String? name;
  final bool? showTheTimePassed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15.r,
          backgroundColor: getRandomColor(),
          child: Center(
            child: Text(
              name != null ? name![0] : '!',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            name ?? "No name mentioned",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (showTheTimePassed == true) ...[
          const Spacer(),
          Text(
            '6h ago',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        ]
      ],
    );
  }
}
