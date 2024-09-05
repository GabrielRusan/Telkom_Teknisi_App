import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/presentation/widgets/login_button.dart';
import 'package:auth/presentation/widgets/login_snackbar.dart';
import 'package:auth/presentation/widgets/text_field_password.dart';
import 'package:auth/presentation/widgets/text_field_username.dart';
import 'package:auth/utils/login_status.dart';
import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/presentations/blocs/profile_bloc/profile_bloc.dart';
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.failed) {
          errorSnackbar(context, 'Login gagal!', state.errorMessage);
        } else if (state.loginStatus == LoginStatus.success) {
          Navigator.of(context).pushReplacementNamed(MyRoutes.homePage);
          context.read<HomepageBloc>().add(const OnChanedIndex(index: 0));
          context.read<ProfileBloc>().add(FetchUserProfileData());
          context.read<ActiveTicketBloc>().add(FetchActiveTicket());
          context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                  child: Image.asset(
                'assets/icons/logo_telkom.png',
                package: 'auth',
                height: 200,
                width: 200,
              )),
              const SizedBox(
                height: 22,
              ),
              const TextFieldUsername(),
              const SizedBox(
                height: 16,
              ),
              const TextFieldPassword(),
              const SizedBox(
                height: 32,
              ),
              const LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
