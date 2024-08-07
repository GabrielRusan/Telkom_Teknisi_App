import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource_impl.dart';
import 'package:auth/data/repositories/auth_repository_impl.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/domain/usecases/get_user_data.dart';
import 'package:auth/domain/usecases/login.dart';
import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:auth/presentation/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:core/presentation/homepage/bloc/homepage_bloc.dart';
import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource_impl.dart';
import 'package:ticket/data/repositories/ticket_repository_impl.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';
import 'package:ticket/domain/usecases/get_active_ticket.dart';
import 'package:ticket/domain/usecases/get_historic_ticket.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //external
  locator.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton(() => DataConnectionChecker());

  //datasources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sharedPref: locator(), dio: locator()));
  locator.registerLazySingleton<TicketRemoteDatasource>(
      () => TicketRemoteDatasourceImpl(sharedPref: locator(), dio: locator()));

  //repositories
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));
  locator.registerLazySingleton<TicketRepository>(() => TicketRepositoryImpl(
      ticketRemoteDatasource: locator(), networkInfo: locator()));

  //usecases
  locator.registerLazySingleton(() => Login(repository: locator()));
  locator.registerLazySingleton(() => GetUserData(repository: locator()));
  locator.registerLazySingleton(
      () => GetActiveTicket(ticketRepository: locator()));
  locator.registerLazySingleton(
      () => GetHistoricTicket(ticketRepository: locator()));

  //blocs
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => SplashScreenBloc(locator()));
  locator.registerFactory(() => HomepageBloc());
  locator.registerFactory(() => HistoricTicketBloc(locator()));

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
}