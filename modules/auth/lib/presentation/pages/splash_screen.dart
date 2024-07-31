import 'dart:async';

import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 2), () {
      context.read<SplashScreenBloc>().add(FetchUserData());
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashScreenFailed) {
          Navigator.of(context).pushReplacementNamed(MyRoutes.loginScreen);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/icons/logo_telkom.png',
                package: 'auth',
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<SplashScreenBloc, SplashScreenState>(
                  builder: (context, state) {
                if (state is SplashScreenLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
