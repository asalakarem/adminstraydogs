import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/modules/login/login_screen.dart';
import 'package:straydogsadmin/shared/components/components.dart';
import 'package:straydogsadmin/shared/network/local/cache_helper.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationRail(
                extended: cubit.isExpanded,
                selectedIndex: cubit.currentIndex,
                onDestinationSelected: (index) {
                  cubit.changeIndex(index);
                },
                labelType: cubit.isExpanded
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.none,
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Image.asset('assets/images/logo.png', width: 40, height: 40),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.brightness_4_outlined),
                      onPressed: () {
                        cubit.changeAppMode();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        cubit.isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        cubit.toggleRail();
                      },
                    ),
                  ],
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.request_page_outlined),
                    selectedIcon: Icon(Icons.request_page),
                    label: Text('Requests'),
                  ),
                  NavigationRailDestination(
                    icon: ImageIcon(AssetImage('assets/images/org_req.png')),
                    selectedIcon: ImageIcon(AssetImage('assets/images/org_req_fill.png')),
                    label: Text('Organization Requests'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.group_outlined),
                    selectedIcon: Icon(Icons.group),
                    label: Text('Organization Approve'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
                trailing: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        tooltip: 'Logout',
                        onPressed: () {
                          CacheHelper.removeData(key: 'userId').then((value) {
                            if (value) {
                              navigateAndFinish(context, LoginScreen());
                            }
                          });
                        },
                      ),
                      if (cubit.isExpanded)
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text('Logout'),
                        ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: cubit.screensWeb[cubit.currentIndex]),
            ],
          ),
        );
      },
    );
  }
}
