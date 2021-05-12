import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tiny/theme/style.dart';

class CustomTextField extends HookWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final bool clearable;
  final String Function(String) validator;
  final void Function() onEditingComplete;
  final TextInputAction textInputAction;
  CustomTextField({
    this.hintText,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.clearable = false,
    this.validator,
    this.onEditingComplete,
    this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    final _focusNode = focusNode ?? useFocusNode();
    final _hasFocus = useState<bool>(false);
    useEffect(() {
      _focusNode.addListener(() {
        _hasFocus.value = _focusNode.hasFocus;
      });
      return () {};
    }, []);
    return Container(
      width: double.infinity,
      height: 70,
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        // focusNode: _focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onEditingComplete: onEditingComplete,
        // style: TextStyle(
        //     fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        decoration: InputDecoration(
          helperText: '',
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          errorStyle: TextStyle(color: new Color(0xFFffc6c6)),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 1.0),
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFffc6c6))),
          suffixIcon: clearable
              ? (_hasFocus.value
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        // color: Colors.white,
                      ),
                      onPressed: () {
                        controller.text = "";
                      },
                    )
                  : null)
              : suffixIcon,
          enabledBorder: UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: ligtGrey2, width: 1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            // borderRadius: BorderRadius.circular(4.0),
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 1.0),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          hintText: hintText,
          hintStyle: TextStyle(color: ligtGrey2),
        ),
      ),
    );
  }
}
