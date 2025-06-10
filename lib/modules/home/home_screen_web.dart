import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/model/org/org_model.dart';
import 'package:straydogsadmin/model/user/user_model.dart';

class HomeScreenWeb extends StatelessWidget {
  final searchController = TextEditingController();

  HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      bloc:
          MainCubit.get(context)
            ..getUsers()
            ..getOrg()
            ..getRequests(),
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Row(
                  spacing: 20,
                  children: [
                    buildItems(
                      context,
                      title: 'Total Users',
                      total: cubit.users.length.toString(),
                      photo: Icons.person,
                    ),
                    buildItems(
                      context,
                      title: 'Total Organizations',
                      total: cubit.organizations.length.toString(),
                      photo: Icons.group,
                    ),
                    buildItems(
                      context,
                      title: 'Total Requests',
                      total: cubit.totalRequests.length.toString(),
                      photo: Icons.request_quote,
                    ),
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color:
                                MainCubit.get(context).isDark
                                    ? Colors.white60
                                    : Colors.black26,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Data Categorization',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Breakdown of processed data by category',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            SizedBox(
                              height: 200,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                  titleSunbeamLayout: true,
                                  sections: [
                                    PieChartSectionData(
                                      value: cubit.users.length.toDouble(),
                                      title: 'User',
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      radius: 70,
                                      color: Colors.blue,
                                      showTitle: true,
                                    ),
                                    PieChartSectionData(
                                      value:
                                          cubit.organizations.length.toDouble(),
                                      title: 'Organization',
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      radius: 70,
                                      color: Colors.purple,
                                      showTitle: true,
                                    ),
                                    PieChartSectionData(
                                      value:
                                          cubit.totalRequests.length.toDouble(),
                                      title: 'Requests',
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      radius: 70,
                                      color: Colors.green,
                                      showTitle: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 320.0,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color:
                                MainCubit.get(context).isDark
                                    ? Colors.white60
                                    : Colors.black26,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cubit.isUserSelected
                                      ? 'User Activity'
                                      : 'Organization Activity',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: SearchBar(
                                      padding: const WidgetStatePropertyAll<
                                        EdgeInsets
                                      >(EdgeInsets.symmetric(horizontal: 16.0)),
                                      leading: const Icon(Icons.search),
                                      hintText: 'Search',
                                      controller: searchController,
                                      onChanged: (value) {
                                        cubit.isUserSelected
                                            ? cubit.filterUsers(value)
                                            : cubit.filterOrg(value);
                                      },
                                      onSubmitted: (value) {
                                        cubit.isUserSelected
                                            ? cubit.filterUsers(value)
                                            : cubit.filterOrg(value);
                                      },
                                    ),
                                  ),
                                ),
                                DropdownMenu<String>(
                                  initialSelection: cubit.selectedValue,
                                  label: Text(cubit.selectedValue),
                                  dropdownMenuEntries: cubit.select,
                                  onSelected: (value) {
                                    if (value != null) {
                                      cubit.updateSelectedValue(value);
                                    }
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder:
                                    (context, index) =>
                                        cubit.isUserSelected
                                            ? buildUserItem(
                                              cubit.filteredUsers[index],
                                            )
                                            : buildOrgItem(
                                              cubit.filteredOrg[index],
                                              context,
                                            ),
                                itemCount:
                                    cubit.isUserSelected
                                        ? cubit.filteredUsers.length
                                        : cubit.filteredOrg.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItems(
    BuildContext context, {
    required String title,
    required String total,
    required IconData photo,
  }) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color:
              MainCubit.get(context).isDark ? Colors.white60 : Colors.black26,
        ),
      ),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(photo),
            ],
          ),
          Text(
            total,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  Widget buildUserItem(UserModel model) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.badge, size: 20),
                const SizedBox(width: 8),
                Text('User ID: ${model.userId}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Text('Name: ${model.firstName} ${model.lastName}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Email: ${model.email}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.lock, size: 20),
                const SizedBox(width: 8),
                Text('Password: ${'*' * (model.password?.length ?? 0)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 20),
                const SizedBox(width: 8),
                Text('Phone: ${model.phoneNumber}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text('Joined: ${model.dateJoined?.substring(0, 10)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrgItem(OrgModel model, BuildContext context) {
    final isActive = model.isActive != 0;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.badge, size: 20),
                const SizedBox(width: 8),
                Text('Organizations ID: ${model.ngoId}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Text('Name: ${model.name}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Email: ${model.email}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.lock, size: 20),
                const SizedBox(width: 8),
                Text('Password: ${'*' * (model.password?.length ?? 0)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 20),
                const SizedBox(width: 8),
                Text('Phone: ${model.phoneNumber}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Text('Address: ${model.address}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 8),
                Text('Joined: ${model.dateJoined?.substring(0, 10)}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.done, size: 20),
                const SizedBox(width: 8),
                const Text('Status:'),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    MainCubit.get(context).activateOrg(
                      isActive: isActive ? 0 : 1,
                      email: '${model.email}',
                    );
                  },
                  child: Text(
                    isActive ? 'Inactivate' : 'Activate',
                    style: TextStyle(
                      fontSize: 14,
                      color: isActive ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
