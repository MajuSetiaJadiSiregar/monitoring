part of 'widgets.dart';

class Input extends StatelessWidget {
  final String hintText;
  final bool isHint;
  final bool isObscurePassword;
  final Function? onClick;


  const Input({super.key, this.hintText='input your username',this.isHint=false, this.isObscurePassword=false, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscurePassword,
      style: const TextStyle(fontFamily: 'PoppinsThin'),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: 'PoppinsThin'),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.brown, width: 2.0),
          ),
          suffixIcon: isObscurePassword ? IconButton(
            onPressed: (){
              if(onClick != null) {
                onClick!();
              }
            },
            icon: Icon(isObscurePassword ? Icons.visibility_off : Icons.visibility),
            color: Colors.brown,
          ) : null
      ),
    );
  }

}