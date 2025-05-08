import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/model/org/org_model.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      bloc: MainCubit.get(context)..getOrgApprove(),
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organization',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder:
                      (context, index) => buildOrgItem(cubit.orgApprove[index]),
                  itemCount: cubit.orgApprove.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildOrgItem(OrgModel model) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              MainCubit.get(
                context,
              ).approveOrg(approvedNgo: 1, email: model.email);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: 'Approve',
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              MainCubit.get(
                context,
              ).approveOrg(approvedNgo: 0, email: model.email);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Reject',
          ),
        ],
      ),
      child: Card(
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
                  Text('Password: ${model.password}'),
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
                  Text('Joined: ${model.dateJoined.substring(0, 10)}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
