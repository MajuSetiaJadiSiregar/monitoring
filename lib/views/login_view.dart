part of 'view.dart';

class LoginView extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context){
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        width: double.infinity,
        height: double.infinity,
        child: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(width: size.width * 1, height: size.height * 0.4),
          const Label(label: 'Sign In', fontSize: AppSize.fontSizeExtraLarge, color: '#000000', fontWeight: 6),
          const Label(label: 'Hi, Welcome back...', fontSize: AppSize.fontSizeSmall, color: '#000000', fontWeight: 4),
          const SizedBox(height: AppSize.marginLarge,),
          _form(context)
        ],
      ),
    );
  }

  Widget _image({double height = 200, double width = 200}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      width: width,
      height: height,
      child: ClipRect(
        child: Image.asset(
          'assets/images/icon.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _form(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Label(label: 'User Name', fontSize: AppSize.fontSizeMedium,),
          Input(hintText: 'input your username', isHint: false, onClick: (){},),
          const SizedBox(height: AppSize.marginMedium,),
          const Label(label: 'Password', fontSize: AppSize.fontSizeMedium,),
          Obx(() {
            return Input(hintText: 'input your password', isHint: true, isObscurePassword: _controller.isObscurePassword.value, onClick: () { _controller.onClick();},);
          }),
          const SizedBox(height: AppSize.marginMedium,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Label(label: 'Forget Password ?', fontWeight: 6, fontSize: AppSize.fontSizeSmall,),
              ),

              GestureDetector(
                onTap: () {
                  if(!_controller.isLoading.value) {
                    _controller.login();
                  }

                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMedium, vertical: AppSize.paddingSmall),
                  decoration: BoxDecoration(
                    color: HexColor('#ffe41b'),
                    borderRadius: BorderRadius.circular(AppSize.borderRadiusMedium)
                  ),
                  child: Obx((){
                    if(_controller.isLoading.value) {
                      return _isLoading();
                    } else {
                      return const Label(label: 'Login', fontWeight: 6, fontSize: AppSize.fontSizeMedium, color: "#000000",);
                    }
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _isLoading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const LoadingBalls(color: AppSize.brown,),
        const LoadingBalls(color: AppSize.brown,),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSize.marginSmall),
          child: const Label(label: 'wait', fontWeight: 6, fontSize: AppSize.fontSizeMedium, color: AppSize.brown,),
        ),
        const LoadingBalls(color: AppSize.brown,),
        const LoadingBalls(color: AppSize.brown,),
      ],
    );
  }


}


