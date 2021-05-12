import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/blocs/login/login_bloc.dart';
import 'package:tiny/screens/login/components/custom-text-field/custom-text-field.dart';
import 'package:tiny/screens/login/components/progress-button/progress-button.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final showPassword = useState<bool>(true);
    final emailController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    final emailFocusNode = useFocusNode();
    final passwordController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    final passwordFocusNode = useFocusNode();
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    void showDialogHandler(error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text("Login failed"),
                content: Text(error.toString()),
                actions: [
                  CupertinoButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: _authBloc,
      listener: (ctx, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return AppScreen(0);
          }));
        }
      },
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (ctx, state) {
            if (state is LoginFailure) {
              showDialogHandler(state.error);
            }
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                      Color(0xFF7852A1),
                      Color(0xFFEF518B),
                    ])),
                child: SafeArea(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      child: KeyboardAvoider(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 30.w, right: 30.w, top: 80.h),
                              child: Column(children: [
                                SvgPicture.asset(
                                  "assets/svg/text-logo-white.svg",
                                  color: Colors.white,
                                  height: 60.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomTextField(
                                  focusNode: emailFocusNode,
                                  hintText: "Email",
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  clearable: true,
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(passwordFocusNode),
                                  validator: Validators.compose([
                                    Validators.required("Email is required."),
                                    // Validators.email("Incorrect email."),
                                  ]),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                CustomTextField(
                                  hintText: "Password",
                                  textInputAction: TextInputAction.done,
                                  controller: passwordController,
                                  obscureText: showPassword.value,
                                  focusNode: passwordFocusNode,
                                  validator: Validators.compose([
                                    Validators.required(
                                        "Password can not be empty."),
                                  ]),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      showPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showPassword.value = !showPassword.value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  child: ProgressButton(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: "Gilroy",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: (controller) {
                                      if (_formKey.currentState.validate()) {
                                        _loginBloc.add(LoginWithEmailPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            controller: controller));
                                      }
                                    },
                                  ),
                                )
                              ])),
                        ),
                      ),
                    ),
                  ],
                )),
              )),
        ),
      ),
    );
  }
}
