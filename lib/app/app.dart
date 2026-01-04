import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/injection/injection.dart';
import '../core/theme/app_theme.dart';
import '../presentation/blocs/auth/auth_bloc.dart';
import '../presentation/blocs/character/character_bloc.dart';
import 'router.dart';

/// Main application widget
class ZeroApp extends StatefulWidget {
  const ZeroApp({super.key});

  @override
  State<ZeroApp> createState() => _ZeroAppState();
}

class _ZeroAppState extends State<ZeroApp> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>();
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<CharacterBloc>(
          create: (_) => getIt<CharacterBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'ZERO',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
