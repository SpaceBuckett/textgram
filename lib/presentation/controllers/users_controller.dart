import 'package:get/get.dart';
import 'package:utor_technical_round/config/services/database_service.dart';

class UsersController extends GetxController {
  final dbService = Get.put(DatabaseService());

  List users = [].obs;
  RxBool isLoadingData = false.obs;

  UsersController() {
    init();
  }

  init() {
    fetchUsers();
  }

  fetchUsers() async {
    isLoadingData.value = true;
    try {
      users = await dbService.fetchUsers();
    } catch (error) {
      Get.snackbar('An Error Occured', error.toString());
    }

    isLoadingData.value = false;
  }
}
