import 'package:get/get.dart';
import 'package:utor_technical_round/config/services/database_service.dart';

class UserPostsController extends GetxController {
  final dbService = Get.put(DatabaseService());
  List posts = [].obs;
  RxBool isLoadingData = false.obs;

  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize userId after the controller is created
    final args = Get.arguments;
    if (args != null && args.containsKey('userId')) {
      userId.value = args['userId'].toString();
      print("GETTING POSTS FOR USER ${userId.value}...");
      fetchUserPosts(userId: userId.value);
    }
  }

  fetchUserPosts({required String userId}) async {
    isLoadingData.value = true;
    try {
      posts = await dbService.fetchUserPosts(
        userId: userId,
      );
    } catch (error, stacktrace) {}

    isLoadingData.value = false;
  }
}
