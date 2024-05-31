
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:utor_technical_round/domain/models/post.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 18.w,
        right: 18.w,
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title ?? "No title specified",
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            post.body?.replaceAll("\n", '') ?? "No body specified",
          ),
        ],
      ),
    );
  }
}
