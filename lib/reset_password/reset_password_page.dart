// reset_password_page.dart
import 'package:flutter/material.dart';
import 'package:ecommerce/responsive.dart';
import '../../components/background.dart';
import 'components/reset_password_form.dart';
import 'components/reset_password_screen_top.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      color: Colors.red,
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileResetPasswordScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: ResetPasswordScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: ResetPasswordForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileResetPasswordScreen extends StatelessWidget {
  const MobileResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ResetPasswordScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: ResetPasswordForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
