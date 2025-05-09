import 'package:straydogsadmin/model/login/login_model.dart';

abstract class MainStates {}

class MainInitialStates extends MainStates {}

class MainChangeBottomNavState extends MainStates {}

class MainAppChangeModeState extends MainStates {}

class MainFilterUsersState extends MainStates {}

class MainGetUserDataState extends MainStates {}

class MainGetUserDataErrorState extends MainStates {
  final String error;

  MainGetUserDataErrorState(this.error);
}

class MainFilterOrgState extends MainStates {}

class MainGetOrgDataState extends MainStates {}

class MainGetOrgDataErrorState extends MainStates {
  final String error;

  MainGetOrgDataErrorState(this.error);
}

class MainGetOrgApproveDataState extends MainStates {}

class MainGetOrgApproveDataErrorState extends MainStates {
  final String error;

  MainGetOrgApproveDataErrorState(this.error);
}

class MainActivateOrgSuccessState extends MainStates {}

class MainActivateOrgErrorState extends MainStates {
  final String error;

  MainActivateOrgErrorState(this.error);
}

class MainApproveOrgSuccessState extends MainStates {}

class MainApproveOrgErrorState extends MainStates {
  final String error;

  MainApproveOrgErrorState(this.error);
}

class MainGetRequestsDataState extends MainStates {}

class MainGetRequestsDataErrorState extends MainStates {
  final String error;

  MainGetRequestsDataErrorState(this.error);
}

class MainGetInProgressDataState extends MainStates {}

class MainGetInProgressDataErrorState extends MainStates {
  final String error;

  MainGetInProgressDataErrorState(this.error);
}

class MainGetAcceptedDataState extends MainStates {}

class MainGetAcceptedDataErrorState extends MainStates {
  final String error;

  MainGetAcceptedDataErrorState(this.error);
}

class MainGetMissionDoneDataState extends MainStates {}

class MainGetMissionDoneDataErrorState extends MainStates {
  final String error;

  MainGetMissionDoneDataErrorState(this.error);
}

class MainUpdateSelectState extends MainStates {}

class MainChangeRailExpansionState extends MainStates {}

class MainLoginSuccessState extends MainStates {
  final LoginModel loginModel;

  MainLoginSuccessState(this.loginModel);
}

class MainLoginErrorState extends MainStates {
  final String error;

  MainLoginErrorState(this.error);
}

class MainChangeObscureTextState extends MainStates {}