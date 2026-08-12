import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/app_router.dart';
import 'core/routing/route_names.dart';
import 'core/theme/app_theme.dart';
import 'core/cubit/favorites_cubit.dart';
import 'core/cubit/avatar_cubit.dart';

void main() {
  runApp(const TourixApp());
}

class TourixApp extends StatelessWidget {
  const TourixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(create: (_) => AvatarCubit()),
      ],
      child: MaterialApp(
        title: 'Tourix',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: RouteNames.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
