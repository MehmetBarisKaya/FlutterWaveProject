import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/product/constants/api_constants.dart';
import 'package:flutter_bootcamp_project/product/cubit/auth_cubit.dart';
import 'package:flutter_bootcamp_project/product/cubit/product_detail_cubit.dart';
import 'package:flutter_bootcamp_project/product/cubit/theme_cubit.dart';
import 'package:flutter_bootcamp_project/product/service/cart_service.dart';
import 'package:flutter_bootcamp_project/product/service/network/product_network_service.dart';
import 'package:flutter_bootcamp_project/product/service/product_service.dart';
import 'package:flutter_bootcamp_project/product/service/user_setvice.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  // getIt.registerLazySingleton(() => AuthCubit(getIt()));
  // Services
  getIt.registerLazySingleton(() => NetworkService.instance);
  getIt.registerLazySingleton(() => CartService(getIt()));
  getIt.registerLazySingleton(() => ProductService(getIt()));

  getIt..registerLazySingleton<ThemeCubit>(ThemeCubit.new);

  // Cubits
  getIt.registerFactory<ProductDetailCubit>(
    () => ProductDetailCubit(
      cartService: getIt<CartService>(),
      username: ApiConstants.username,
    ),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(FirebaseAuthService()),
  );
}
