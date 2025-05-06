import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/custom_scroll_behavior.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/layout/mobile_screen.dart';
import 'package:straydogsadmin/layout/web_screen.dart';
import 'package:straydogsadmin/modules/login/login_screen.dart';
import 'package:straydogsadmin/shared/my_bloc_observer.dart';
import 'package:straydogsadmin/shared/network/local/cache_helper.dart';
import 'package:straydogsadmin/shared/network/remote/dio_helper.dart';
import 'package:straydogsadmin/shared/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  final bool? isDark = CacheHelper.getData(key: 'isDark');
  Bloc.observer = MyBlocObserver();
  Widget startWidget;
  final int? userId = CacheHelper.getData(key: 'userId');
  userId != null
      ? startWidget = LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 600) {
            return const MobileScreen();
          }
          return const WebScreen();
        },
      )
      : startWidget = LoginScreen();
  runApp(MyApp(isDark: isDark, startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({super.key, required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            scrollBehavior: CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode:
                MainCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
