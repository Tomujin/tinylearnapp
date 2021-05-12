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
import 'package:tiny/screens/signup/apply-screen.dart';
import 'package:tiny/theme/style.dart';
import 'package:tiny/components/white-center.dart';
import 'package:tiny/screens/signin/components/progress-button/progress-button.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final showPassword = useState<bool>(true);
    final emailController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    final phoneController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    final emailFocusNode = useFocusNode();
    final passwordController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    final passwordFocusNode = useFocusNode();
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    String dropdownValue = '+976';

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
            if (state is SignUpSuccess) {
              print("---SignUp success ---${_authBloc.state}");
              //  _authBloc.add(UserLoggedIn());
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return ApplyScreen();
                }),
              );
            }
          },
          child: pinkContainer(
            context: context,
            child: SingleChildScrollView(
              child: KeyboardAvoider(
                // child: Form(
                //   key: _formKey,
                child: whiteCenter(
                  title: "WELCOME",
                  height: 500.h,
                  context: context,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            // setState(() {
                            //   dropdownValue = newValue;
                            // });
                          },
                          items: <String>['+976', '+84']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 43, right: 43),
                        child: CustomTextField(
                          focusNode: emailFocusNode,
                          hintText: "Phone number",
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          clearable: true,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                          validator: Validators.compose([
                            Validators.required("Phone number is required."),
                            // Validators.email("Incorrect email."),
                          ]),
                        ),
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
                            "Sign up",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: (controller) {
                            // if (_formKey.currentState.validate()) {
                            _loginBloc.add(SignUpWithMobile(
                                email: emailController.text,
                                password: passwordController.text,
                                phoneNumber: phoneController.text,
                                controller: controller));
                            // }
                          },
                        ),
                      ),
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
