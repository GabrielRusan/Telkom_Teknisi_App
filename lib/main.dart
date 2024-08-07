import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:auth/presentation/pages/login_screen.dart';
import 'package:auth/presentation/pages/splash_screen.dart';
import 'package:core/presentation/homepage/bloc/homepage_bloc.dart';
import 'package:core/presentation/homepage/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_teknisi_app/injection.dart' as di;
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/pages/detail_ticket_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // dependency injections
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => di.locator<LoginBloc>(),
        ),
        BlocProvider<SplashScreenBloc>(
          create: (_) => di.locator<SplashScreenBloc>(),
        ),
        BlocProvider<HomepageBloc>(
          create: (_) => di.locator<HomepageBloc>(),
        ),
        BlocProvider<HistoricTicketBloc>(
          create: (_) => di.locator<HistoricTicketBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Telkom Teknisi App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.detailTicketPage,
        routes: {
          MyRoutes.splashScreen: (_) => const SplashScreen(),
          MyRoutes.loginScreen: (_) => const LoginScreen(),
          MyRoutes.homePage: (_) => const HomePage(),
          MyRoutes.detailTicketPage: (_) => const DetailTicketPage(),
        },
      ),
    );
  }
}
