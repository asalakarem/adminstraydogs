import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/modules/login/login_screen.dart';
import 'package:straydogsadmin/shared/components/components.dart';
import 'package:straydogsadmin/shared/network/local/cache_helper.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            title: Row(
              spacing: 10,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
                const Text('Stray Dogs Admin'),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  cubit.changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screensMobile[cubit.currentIndex],
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Row(
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                      const Text('Stray Dogs Admin'),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  selected: cubit.currentIndex == 0,
                  selectedTileColor: cubit.isDark ? Colors.grey[900] : Colors.grey[200],
                  onTap: ()
                  {
                    cubit.changeIndex(0);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.request_page),
                  title: const Text('Requests'),
                  selected: cubit.currentIndex == 1,
                  selectedTileColor: cubit.isDark ? Colors.grey[900] : Colors.grey[200],
                  onTap: (){
                    cubit.changeIndex(1);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('Organization SignUp'),
                  selected: cubit.currentIndex == 2,
                  selectedTileColor: cubit.isDark ? Colors.grey[900] : Colors.grey[200],
                  onTap: (){
                    cubit.changeIndex(2);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  selected: cubit.currentIndex == 3,
                  selectedTileColor: cubit.isDark ? Colors.grey[900] : Colors.grey[200],
                  onTap: (){
                    cubit.changeIndex(3);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: const Text('Logout'),
                  onTap: (){
                    CacheHelper.removeData(key: 'userId').then((value) {
                      if(value)
                      {
                        navigateAndFinish(context, LoginScreen());
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}