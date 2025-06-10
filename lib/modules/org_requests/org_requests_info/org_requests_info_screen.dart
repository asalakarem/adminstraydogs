import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/cubit.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/model/request/request_model.dart';

class OrgRequestsInfoScreen extends StatelessWidget {
  final int orgId;

  const OrgRequestsInfoScreen({super.key, required this.orgId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      bloc: MainCubit.get(context)..getAllRequests(orgId: orgId),
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Organization Requests Info')),
          body: ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemBuilder:
                (context, index) => buildRequestItem(cubit.allRequests[index]),
            itemCount: cubit.allRequests.length,
          ),
        );
      },
    );
  }

  Widget buildRequestItem(RequestModel model) {
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
                const Icon(Icons.numbers, size: 20),
                const SizedBox(width: 8),
                Text('Request ID: ${model.requestId}'),
              ],
            ),
            const SizedBox(height: 8),
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
                Text('User Name: ${model.userName}'),
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
                Text('Address: ${model.streetAddress}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.description, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Description: ${model.description}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.pets, size: 20),
                const SizedBox(width: 8),
                Text('Dogs Count: ${model.dogsCount}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timelapse, size: 20),
                const SizedBox(width: 8),
                Text('Submitted: ${model.submissionTime?.substring(0, 10)}'),
              ],
            ),
            if (model.status == 'Accepted') ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 20),
                  const SizedBox(width: 8),
                  Text('Accepted: ${model.acceptedDate?.substring(0, 10)}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 20),
                  const SizedBox(width: 8),
                  Text('Accepted By: ${model.acceptedNgo}'),
                ],
              ),
            ],
            if (model.status == 'Mission Done') ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Mission Done: ${model.missionDoneDate?.substring(0, 10)}',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 20),
                  const SizedBox(width: 8),
                  Text('Mission Done By: ${model.missionDoneNgo}'),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 20),
                const SizedBox(width: 8),
                Text('Status: ${model.status}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
