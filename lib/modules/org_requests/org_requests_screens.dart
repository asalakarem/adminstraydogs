import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/model/org/org_model.dart';
import 'package:straydogsadmin/modules/org_requests/org_requests_info/org_requests_info_screen.dart';
import 'package:straydogsadmin/shared/components/components.dart';

class OrgRequestsScreens extends StatelessWidget {
  const OrgRequestsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organization Requests',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder:
                      (context, index) =>
                          buildItem(cubit.organizations[index], context),
                  itemCount: cubit.organizations.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildItem(OrgModel model, BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, OrgRequestsInfoScreen(orgId: model.ngoId!));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow(Icons.badge, 'ID: ${model.ngoId!}'),
            const SizedBox(height: 10),
            buildInfoRow(Icons.business, model.name!),
            const SizedBox(height: 10),
            buildInfoRow(Icons.email, model.email!),
            const SizedBox(height: 10),
            buildInfoRow(Icons.phone, '${model.phoneNumber!}'),
            const SizedBox(height: 10),
            buildInfoRow(Icons.location_on, model.address!),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}
