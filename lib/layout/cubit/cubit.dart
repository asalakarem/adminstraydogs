import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:straydogsadmin/layout/cubit/states.dart';
import 'package:straydogsadmin/model/login/login_model.dart';
import 'package:straydogsadmin/model/org/org_model.dart';
import 'package:straydogsadmin/model/request/request_model.dart';
import 'package:straydogsadmin/model/user/user_model.dart';
import 'package:straydogsadmin/modules/home/home_screen_mobile.dart';
import 'package:straydogsadmin/modules/home/home_screen_web.dart';
import 'package:straydogsadmin/modules/organization/organization_screen.dart';
import 'package:straydogsadmin/modules/profile/profile_screen.dart';
import 'package:straydogsadmin/modules/requests/requests_screen.dart';
import 'package:straydogsadmin/shared/network/endPoint.dart';
import 'package:straydogsadmin/shared/network/local/cache_helper.dart';
import 'package:straydogsadmin/shared/network/remote/dio_helper.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(MainChangeBottomNavState());
  }

  final List<Widget> screensWeb = [
    const HomeScreenWeb(),
    const RequestsScreen(),
    const OrganizationScreen(),
    ProfileScreen(),
  ];

  final List<Widget> screensMobile = [
    const HomeScreenMobile(),
    const RequestsScreen(),
    const OrganizationScreen(),
    ProfileScreen(),
  ];

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(MainAppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(MainAppChangeModeState());
      });
    }
  }

  List<UserModel> users = [];

  void getUsers() {
    DioHelper.getData(url: TOTAL_USERS)
        .then((value) {
          users =
              (value.data as List).map((e) => UserModel.fromJson(e)).toList();
          emit(MainGetUserDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetUserDataErrorState(error.toString()));
        });
  }

  List<OrgModel> organizations = [];

  void getOrg() {
    DioHelper.getData(url: TOTAL_ORGS)
        .then((value) {
          organizations =
              (value.data as List).map((e) => OrgModel.fromJson(e)).toList();
          emit(MainGetOrgDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetOrgDataErrorState(error.toString()));
        });
  }

  List<OrgModel> orgApprove = [];

  void getOrgApprove() {
    DioHelper.getData(url: GET_NGOS_NOT_APPROVED)
        .then((value) {
          orgApprove =
              (value.data as List).map((e) => OrgModel.fromJson(e)).toList();
          emit(MainGetOrgApproveDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetOrgApproveDataErrorState(error.toString()));
        });
  }

  void activateOrg({required int isActive, required String email}) {
    DioHelper.putData(
          url: ACTIVE_ORG,
          data: {'email': email, 'isActive': isActive},
        )
        .then((value) {
          emit(MainActivateOrgSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainActivateOrgErrorState(error.toString()));
        });
  }

  void approveOrg({required int approvedNgo, required String email}) {
    DioHelper.putData(
          url: APPROVE_ORG,
          data: {'email': email, 'approvedNgo': approvedNgo},
        )
        .then((value) {
          orgApprove.removeWhere((element) => element.email == email);
          emit(MainApproveOrgSuccessState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainApproveOrgErrorState(error.toString()));
        });
  }

  List<dynamic> totalRequests = [];

  void getRequests() {
    DioHelper.getData(url: TOTAL_REQUESTS)
        .then((value) {
          totalRequests = value.data;
          emit(MainGetRequestsDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetRequestsDataErrorState(error.toString()));
        });
  }

  List<RequestModel> inProgress = [];

  void getInProgress() {
    DioHelper.getData(url: GET_IN_PROGRESS)
        .then((value) {
          inProgress =
              (value.data as List)
                  .map((e) => RequestModel.fromJson(e))
                  .toList();
          emit(MainGetInProgressDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetInProgressDataErrorState(error.toString()));
        });
  }

  List<RequestModel> accepted = [];

  void getAccepted() {
    DioHelper.getData(url: GET_ACCEPTED)
        .then((value) {
          accepted =
              (value.data as List)
                  .map((e) => RequestModel.fromJson(e))
                  .toList();
          emit(MainGetAcceptedDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetAcceptedDataErrorState(error.toString()));
        });
  }

  List<RequestModel> missionDone = [];

  void getMissionDone() {
    DioHelper.getData(url: GET_DONE)
        .then((value) {
          missionDone =
              (value.data as List)
                  .map((e) => RequestModel.fromJson(e))
                  .toList();
          emit(MainGetMissionDoneDataState());
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainGetMissionDoneDataErrorState(error.toString()));
        });
  }

  String selectedValue = 'User';

  bool get isUserSelected => selectedValue == 'User';

  final List<DropdownMenuEntry<String>> select = [
    const DropdownMenuEntry(value: 'User', label: 'User'),
    const DropdownMenuEntry(value: 'Organizations', label: 'Organizations'),
  ];

  void updateSelectedValue(String value) {
    selectedValue = value;
    emit(MainUpdateSelectState());
  }

  LoginModel? loginModel;

  void login({required String email, required String password}) {
    DioHelper.getData(url: LOGIN, query: {'email': email, 'password': password})
        .then((value) {
          loginModel = LoginModel.fromJson(value.data);
          CacheHelper.saveData(
            key: 'userData',
            value: json.encode(loginModel!.toJson()),
          );
          emit(MainLoginSuccessState(loginModel!));
        })
        .catchError((dynamic error) {
          print(error.toString());
          emit(MainLoginErrorState(error.toString()));
        });
  }

  bool obscureText = true;

  void changeObscureText() {
    obscureText = !obscureText;
    emit(MainChangeObscureTextState());
  }

  void loadLoginData() {
    final jsonString = CacheHelper.getData(key: 'userData');

    if (jsonString != null) {
      loginModel = LoginModel.fromJson(json.decode(jsonString));
      emit(MainLoginSuccessState(loginModel!));
    }
  }

  bool isExpanded = false;

  void toggleRail() {
    isExpanded = !isExpanded;
    emit(MainChangeRailExpansionState());
  }
}
