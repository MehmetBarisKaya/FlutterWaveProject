import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/cubit/product_cubit.dart';
import 'package:flutter_bootcamp_project/product/cubit/theme_cubit.dart';
import 'package:flutter_bootcamp_project/product/service/network/product_network_service.dart';
import 'package:flutter_bootcamp_project/product/service/product_service.dart';
import 'package:get_it/get_it.dart';

final class StateInitialize extends StatelessWidget {
  const StateInitialize({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit(
            ProductService(NetworkService.instance),
          )..fetchProducts(),
        ),
        BlocProvider<ThemeCubit>.value(
          value: GetIt.I<ThemeCubit>(),
        ),
      ],
      child: child,
    );
  }
}
