import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldUsername extends StatelessWidget {
  const TextFieldUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFieldWidget(
        prefixIcon: const Icon(Icons.person),
        hintText: 'Username',
        onChange: (value) {
          context.read<LoginBloc>().add(UsernameChanged(value: value));
        },
      );
    });
  }
}
