import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/utils/login_status.dart';
import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return ButtonWidget.defaultContainer(
          child: state.loginStatus == LoginStatus.inProggres
              ? const Center(child: CircularProgressIndicator())
              : Text(
                  'Masuk',
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeight.w600,
                    color: ColorThemeStyle.white100,
                  ),
                ),
          onPressed: () {
            context.read<LoginBloc>().add(SignIn());
          });
    });
  }
}
