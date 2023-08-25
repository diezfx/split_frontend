import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:split_frontend/config/config.dart';
import 'package:split_frontend/cubit/auth_cubit.dart';
import 'package:split_frontend/cubit/cost_element_details.dart';
import 'package:split_frontend/cubit/expenses.dart';
import 'package:split_frontend/cubit/user.dart';
import 'package:split_frontend/pkg/theme/color_schemes.g.dart';
import 'package:split_frontend/screens/create_cost_element.dart';
import 'package:split_frontend/screens/create_project.dart';
import 'package:split_frontend/screens/expense_details.dart';
import 'package:split_frontend/screens/login.dart';
import 'package:split_frontend/screens/project_list_screen.dart';
import 'package:split_frontend/screens/project_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_web_plugins/url_strategy.dart';

import 'expenses/repository.dart';

final supabase = Supabase.instance.client;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  var envConfig = await EnvConfig.loadConfig();

  await Supabase.initialize(
    url: envConfig.supabase.url,
    anonKey: envConfig.supabase.anonKey,
  );

  if (kIsWeb) {
    usePathUrlStrategy();
  }

  runApp(MyApp(envConfig));
}

class MyApp extends StatelessWidget {
  final EnvConfig envConfig;
  MyApp(this.envConfig, {super.key});

  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: supabase.auth.currentSession == null ? '/sign-in' : '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => ProjectListScreen()),
      GoRoute(
          path: '/sign-in', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/login-callback', redirect: (context, state) => "/"),
      GoRoute(
          path: '/create-project',
          builder: (context, state) => const CreateProjectScreen("user1")),
      GoRoute(
          path: '/projects/:projectId',
          builder: (context, state) =>
              ProjectDetailsScreen(state.pathParameters["projectId"])),
      GoRoute(
          path: '/projects/:projectId/elements/:elementId',
          builder: (context, state) => ExpensesDetailsScreen(
              state.pathParameters["projectId"],
              state.pathParameters["elementId"])),
      GoRoute(
          path: '/projects/:projectId/create-element',
          builder: (context, state) => CreateCostElementScreen(
                "user1",
                state.pathParameters["projectId"]!,
              )),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IExpenseRepository>(
                create: (context) =>
                    ExpenseRepository(Config(envConfig.splitrBackendUrl)))
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) =>
                    ProjectCubit(context.read<IExpenseRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    CostElementCubit(context.read<IExpenseRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    UserCubit(context.read<IExpenseRepository>()),
              ),
            ],
            child: MaterialApp.router(routerConfig: _router),
          ),
        ));
  }
}
