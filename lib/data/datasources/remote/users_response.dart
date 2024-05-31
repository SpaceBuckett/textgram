import 'package:utor_technical_round/domain/models/user.dart';
import 'package:utor_technical_round/utils/resources/base_response.dart';
import 'package:utor_technical_round/utils/resources/request_response.dart';

class UsersResponse extends BaseResponse {
  List<User> users = [];

  UsersResponse(success, {error}) : super(success, error: error);

  UsersResponse.fromRequestResponse(RequestResponse response)
      : super(response.success, error: response.error) {
    if (response.data['body'] != null) {
      response.data['body'].forEach((value) {
        users.add(User.fromJson(value));
      });
      print('USERS LENGTH: ${users.length}');
    } else {
      print('NO DATA HAS BEEN RETURNED BY USERS API');
    }
  }
}
