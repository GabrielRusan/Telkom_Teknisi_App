import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldPassword extends StatefulWidget {
  final TextEditingController? controller;
  const TextFieldPassword({super.key, this.controller});

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFieldWidget(
          controller: widget.controller,
          prefixIcon: const Icon(
            Icons.lock,
            size: 22,
          ),
          hintText: 'Password',
          obscureText: !isVisible,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child:
                    Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
          ),
          onChange: (value) {
            context.read<LoginBloc>().add(PasswordChanged(value: value));
          },
        );
      },
    );
  }
}
