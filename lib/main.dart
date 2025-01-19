import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:auth/presentation/pages/login_screen.dart';
import 'package:auth/presentation/pages/splash_screen.dart';
import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:core/presentation/pages/homepage.dart';
import 'package:core/utils/route_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:profile/presentations/blocs/edit_foto_profile_bloc/edit_foto_profile_bloc.dart';
import 'package:profile/presentations/blocs/profile_bloc/profile_bloc.dart';
import 'package:telkom_teknisi_app/firebase_options.dart';
import 'package:telkom_teknisi_app/injection.dart' as di;
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/blocs/update_ticket_bloc/update_ticket_bloc.dart';
import 'package:ticket/presentation/pages/detail_ticket_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null);
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
        BlocProvider<ActiveTicketBloc>(
          create: (_) => di.locator<ActiveTicketBloc>(),
        ),
        BlocProvider<UpdateTicketBloc>(
          create: (_) => di.locator<UpdateTicketBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => di.locator<ProfileBloc>(),
        ),
        BlocProvider<EditFotoProfileBloc>(
          create: (_) => di.locator<EditFotoProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Telkom Teknisi App',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(surfaceTintColor: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        initialRoute: MyRoutes.splashScreen,
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
