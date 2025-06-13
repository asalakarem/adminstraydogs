import 'dart:convert';

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
            itemBuilder: (context, index) =>
                buildRequestItem(cubit.allRequests[index], context),
            itemCount: cubit.allRequests.length,
          ),
        );
      },
    );
  }

  Widget buildRequestItem(RequestModel model, BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width > 700;

    Widget buildInfoRow(IconData icon, String label, {bool isExpandable = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 8),
            isExpandable
                ? Expanded(child: Text(label, style: theme.textTheme.bodyMedium))
                : Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.dogImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  base64Decode(model.dogImage!),
                  width: double.infinity,
                  height: isWide ? 300 : 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            buildInfoRow(Icons.numbers, 'Request ID: ${model.requestId}'),
            buildInfoRow(Icons.badge, 'User ID: ${model.userId}'),
            buildInfoRow(Icons.person, 'User Name: ${model.userName}'),
            buildInfoRow(Icons.phone, 'Phone: ${model.phoneNumber}'),
            buildInfoRow(Icons.location_on, 'Address: ${model.streetAddress}', isExpandable: true),
            buildInfoRow(Icons.description, 'Description: ${model.description}', isExpandable: true),
            buildInfoRow(Icons.pets, 'Dogs Count: ${model.dogsCount}'),
            buildInfoRow(Icons.timelapse, 'Submitted: ${model.submissionTime?.substring(0, 10)}'),

            if (model.status == 'Accepted') ...[
              const Divider(height: 24),
              buildInfoRow(Icons.check_circle, 'Accepted: ${model.acceptedDate?.substring(0, 10)}'),
              buildInfoRow(Icons.person, 'Accepted By: ${model.acceptedNgo}'),
            ],

            if (model.status == 'Mission Done') ...[
              const Divider(height: 24),
              buildInfoRow(Icons.check_circle, 'Mission Done: ${model.missionDoneDate?.substring(0, 10)}'),
              buildInfoRow(Icons.person, 'Mission Done By: ${model.missionDoneNgo}'),
              const SizedBox(height: 8),
              FutureBuilder<String>(
                future: MainCubit.get(context).getAddressFromLatLng(model.latitude, model.longitude),
                builder: (context, snapshot) {
                  String text;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    text = 'Loading address...';
                  } else if (snapshot.hasError) {
                    text = 'Address not found';
                  } else {
                    text = snapshot.data!;
                  }
                  return buildInfoRow(Icons.location_on, text, isExpandable: true);
                },
              ),
            ],

            const Divider(height: 24),
            buildInfoRow(Icons.info_outline, 'Status: ${model.status}'),
          ],
        ),
      ),
    );
  }
}
