import 'package:food_delivery_app/data/repositories/auth_repo.dart';
import 'package:food_delivery_app/modals/response_modal.dart';
import 'package:food_delivery_app/modals/signup_body_modal.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModal> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModal responseModal;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      print("token = ${response.body['token']}");
      responseModal = ResponseModal(true, response.body['token']);
    } else {
      responseModal = ResponseModal(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModal;
  }

  Future<ResponseModal> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModal responseModal;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      print("token = ${response.body['token']}");
      responseModal = ResponseModal(true, response.body['token']);
    } else {
      responseModal = ResponseModal(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModal;
  }

  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }
}
