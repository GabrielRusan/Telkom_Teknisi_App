import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockSplashScreenBloc
    extends MockBloc<SplashScreenEvent, SplashScreenState>
    implements SplashScreenBloc {}
