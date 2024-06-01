import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:utor_technical_round/domain/models/comment.dart';
import 'package:utor_technical_round/domain/models/post.dart';
import 'package:utor_technical_round/domain/models/user.dart';
import 'package:utor_technical_round/utils/constants/end_points.dart';

class DatabaseService {
  Future<List<User>> fetchUsers() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${EndPoints.baseUrl}/${EndPoints.allUsers}',
      );

      final List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return [];
    }
  }

  Future<List<Post>> fetchUserPosts({
    required String userId,
  }) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${EndPoints.baseUrl}/${EndPoints.allPostOfAUser}',
        queryParameters: {
          'userId': userId,
        },
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return [];
    }
  }

  Future<List<Comment>> fetchPostComments({required String postId}) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${EndPoints.baseUrl}/posts/$postId/comments',
      );

      final List<dynamic> data = response.data;
      return data.map((json) => Comment.fromJson(json)).toList();
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return [];
    }
  }
}
