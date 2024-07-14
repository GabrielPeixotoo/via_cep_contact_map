import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'modules/home/home.dart';
import 'modules/login/login.dart';
import 'modules/splash/splash.dart';
import 'shared/shared.dart';

class AppModule extends BaseModule {
  List<BaseModule> get modules => [SplashModule(), HomeModule(), LoginModule()];

  @override
  Future<void> init() async {
    instance.registerFactory<CheckConnectivity>(
      () => ConnectivityPlusAdapter(connectivity: Connectivity()),
    );
    instance.registerLazySingleton<Dio>(Dio.new);
    instance.registerLazySingleton<HttpInspector>(ChuckAdapter.new);
    instance.registerLazySingleton<LocalStorage>(LocalStorageHiveAdapter.new);
    instance.registerLazySingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>.new,
    );
    instance.registerLazySingleton<AppNavigator>(
      () => AppNavigatorImpl(navigatorKey: instance()),
    );
    instance.registerLazySingleton<UIHelper>(
      () => UIHelperImpl(navigatorKey: instance()),
    );
    instance.registerFactory<FetchUsersUsecase>(
      () => LocalFetchUser(localStorage: instance()),
    );
    instance.registerFactory<DeleteUserUsecase>(
      () => LocalDeleteUser(localStorage: instance()),
    );
    instance.registerFactory<SaveUserUsecase>(
      () => LocalSaveUser(
        localStorage: instance(),
        fetchUsersUsecase: instance(),
      ),
    );
    instance.registerFactory<SignUpUsecase>(
      () => LocalSignUp(fetchUsersUsecase: instance(), saveUserUsecase: instance()),
    );
    instance.registerFactory<FetchCurrentUserUsecase>(
      () => LocalFetchCurrentUser(localStorage: instance()),
    );
    instance.registerFactory<DeleteCurrentUserUsecase>(
      () => LocalDeleteCurrentUser(localStorage: instance()),
    );
    instance.registerLazySingleton<HttpClient>(
      () => DioAdapter(
        dio: instance(),
        checkConnectivity: instance(),
        httpInspector: instance(),
        createToken: CancelToken.new,
      ),
    );
    instance.registerLazySingleton<AuthClientDecorator>(
      () => AuthClientDecorator(
        appNavigator: instance(),
        deleteAuthUsecase: instance(),
        fetchAuthUsecase: instance(),
        client: instance(),
      ),
    );

    for (final module in modules) {
      await module.init();
    }
  }
}
