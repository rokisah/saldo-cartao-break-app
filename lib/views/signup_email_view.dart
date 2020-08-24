import 'package:flutter/material.dart';
import 'package:break_balance/routing/routing_constants.dart';
import 'package:break_balance/views/shared/ui_helpers.dart';
import 'package:break_balance/views/widgets/input_field.dart';
import 'package:break_balance/views/widgets/busy_button.dart';
import 'package:break_balance/services/sign_in_service.dart'
    as SigninService;

class SignupEmailView extends StatefulWidget {
  @override
  _SignupEmailViewState createState() => _SignupEmailViewState();
}

class _SignupEmailViewState extends State<SignupEmailView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 38,
              ),
            ),
            verticalSpaceLarge,
            InputField(
              placeholder: 'Full Name',
              controller: fullNameController,
            ),
            verticalSpaceSmall,
            InputField(
              placeholder: 'Email',
              controller: emailController,
            ),
            verticalSpaceSmall,
            InputField(
              placeholder: 'Password',
              password: true,
              controller: passwordController,
              additionalNote: 'Password has to be a minimum of 6 characters.',
            ),
            verticalSpaceMedium,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BusyButton(
                  title: 'Sign Up',
                  onPressed: () {
                    signUp(
                      emailController.text,
                      passwordController.text,
                      fullNameController.text
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String fullName) {
    SigninService.signUpWithEmail(email, password, fullName).whenComplete(() => {
      Navigator.popAndPushNamed(context, ManageCardsViewRoute)
    });
  }
}
