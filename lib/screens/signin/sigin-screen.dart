import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/blocs/login/login_bloc.dart';
import 'package:tiny/components/custom-text-field/custom-text-field.dart';
import 'package:tiny/components/pink-container.dart';
import 'package:tiny/theme/style.dart';
import 'package:tiny/components/white-center.dart';
import 'package:tiny/screens/signin/components/progress-button/progress-button.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignInScreen extends HookWidget {
  const SignInScreen({Key key}) : super(key: key);
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
        print("auth bloc listener$state");
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
            if (state is LoginSuccess) {
              print("---Login success ---${_authBloc.state}");
              _authBloc.add(UserLoggedIn());
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (ctx) {
              //     return AppScreen(0);
              //   }),
              // );
            }
          },
          child: pinkContainer(
            context: context,
            child: SingleChildScrollView(
              child: KeyboardAvoider(
                // child: Form(
                //   key: _formKey,
                child: whiteCenter(
                  title: "WELCOME BACK",
                  context: context,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 43, right: 43),
                        child: CustomTextField(
                          focusNode: emailFocusNode,
                          hintText: "Email",
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          clearable: true,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(passwordFocusNode),
                          validator: Validators.compose([
                            Validators.required("Email is required."),
                            // Validators.email("Incorrect email."),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 43, right: 43),
                        child: CustomTextField(
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          obscureText: showPassword.value,
                          focusNode: passwordFocusNode,
                          validator: Validators.compose([
                            Validators.required("Password can not be empty."),
                          ]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              showPassword.value = !showPassword.value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Container(
                        height: 50.h,
                        margin:
                            EdgeInsets.only(left: 65.w, right: 65.w, top: 1),
                        width: double.infinity,
                        child: ProgressButton(
                          color: purple,
                          borderRadius: BorderRadius.circular(10),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: (controller) {
                            // if (_formKey.currentState.validate()) {
                            _loginBloc.add(LoginWithEmailPassword(
                                email: emailController.text,
                                password: passwordController.text,
                                controller: controller));
                            // }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 49,
                      ),
                      InkWell(
                          onTap: () async {
                            // await widget.browser.open(
                            //     url: authRepo.authorizationUrl,
                            //     options: ChromeSafariBrowserClassOptions(
                            //         android: AndroidChromeCustomTabsOptions(
                            //             addDefaultShareMenuItem: false),
                            //         ios: IOSSafariOptions(
                            //             barCollapsingEnabled: false,
                            //             presentationStyle:
                            //                 IOSUIModalPresentationStyle
                            //                     .FORM_SHEET)));
                          },
                          child: Text(
                            "Login with gmail.com",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xffef508b),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
