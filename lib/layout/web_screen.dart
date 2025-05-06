import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';

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
                labelType: cubit.isExpanded ? NavigationRailLabelType.none : NavigationRailLabelType.none,
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.0,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/logo.png', width: 40, height: 40),
                        cubit.isExpanded ? const Text('Stray Dogs Admin') : const SizedBox.shrink(),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.brightness_4_outlined,
                      ),
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
                    selectedIcon: Icon(Icons.home, color: Colors.blue),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.request_page_outlined),
                    selectedIcon: Icon(Icons.request_page, color: Colors.blue),
                    label: Text('Requests'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.group_outlined),
                    selectedIcon: Icon(Icons.group, color: Colors.blue),
                    label: Text('Organization'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person, color: Colors.blue),
                    label: Text('Profile'),
                  ),
                ],
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
