part of 'controller.dart';

abstract class LoginContract {
  void login();
  void onClick();
}

class LoginController extends GetxController implements LoginContract {

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  var isLoading = false.obs;
  var isObscurePassword = true.obs;


  @override
  Future<void> login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;
    Get.to(() => HomeView(), transition: Transition.rightToLeft);
  }

  @override
  void onClick() {
    isObscurePassword.value = !isObscurePassword.value;
  }


}