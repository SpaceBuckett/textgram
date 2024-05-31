import 'package:get/get.dart';
import 'package:utor_technical_round/config/services/database_service.dart';

class PostDetailsController extends GetxController {
  final dbService = Get.put(DatabaseService());
  List comments = [].obs;
  RxBool isLoadingComments = false.obs;

  var postId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize userId after the controller is created
    final args = Get.arguments;
    if (args != null && args.containsKey('postId')) {
      postId.value = args['postId'].toString();
      print("GETTING COMMENTS FOR POST ${postId.value}...");
      fetchUserPosts(postId: postId.value);
    }
  }

  fetchUserPosts({required String postId}) async {
    isLoadingComments.value = true;
    try {
      comments = await dbService.fetchPostComments(
        postId: postId,
      );
    } catch (error, stacktrace) {}

    isLoadingComments.value = false;
  }
}
