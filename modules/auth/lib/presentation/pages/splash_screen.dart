import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:core/styles/color_theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/route_observer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() async {
    await Future.delayed(const Duration(seconds: 2)).then(
      (value) => context.read<SplashScreenBloc>().add(FetchUserData()),
    );
    super.didPop();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is SplashScreenFailed) {
          Navigator.of(context).pushReplacementNamed(MyRoutes.loginScreen);
        } else if (state is SplashScreenSuccess) {
          Navigator.of(context).pushReplacementNamed(MyRoutes.homePage);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/icons/logo_telkom.png',
                package: 'auth',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<SplashScreenBloc, SplashScreenState>(
                builder: (context, state) {
              if (state is SplashScreenLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: ColorThemeStyle.redPrimary,
                ));
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }
}
