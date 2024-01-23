class LoginUserModel {
  int? statusCode;
  bool? success;
  Data? data;
  String? message;

  LoginUserModel({this.statusCode, this.success, this.data, this.message});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'] as int?;
    success = json['success'] as bool?;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? usersID;
  String? userName;
  String? userPhone;
  String? password;
  String? email;
  String? userToken;
  String? userFirebaseToken;
  String? loginType;
  String? socialid;
  String? userPhoto;
  String? userStatus;
  String? lastUpdatedUsers;
  String? createdAtUser;
  String? userRate;
  String? userTimesOfRates;
  String? userTotalRates;
  String? tripNumber;
  String? hasTrip;
  String? login;
  String? userVersion;
  String? userBalance;

  Data(
      {this.usersID,
      this.userName,
      this.userPhone,
      this.password,
      this.email,
      this.userToken,
      this.userFirebaseToken,
      this.loginType,
      this.socialid,
      this.userPhoto,
      this.userStatus,
      this.lastUpdatedUsers,
      this.createdAtUser,
      this.userRate,
      this.userTimesOfRates,
      this.userTotalRates,
      this.tripNumber,
      this.hasTrip,
      this.login,
      this.userVersion,
      this.userBalance});

  Data.fromJson(json) {
    usersID = json['UsersID'];
    userName = json['UserName'];
    userPhone = json['UserPhone'];
    password = json['Password'];
    email = json['Email'];
    userToken = json['UserToken'];
    userFirebaseToken = json['UserFirebaseToken'];
    loginType = json['LoginType'];
    socialid = json['Socialid'];
    userPhoto = json['UserPhoto'];
    userStatus = json['UserStatus'];
    lastUpdatedUsers = json['lastUpdatedUsers'];
    createdAtUser = json['CreatedAtUser'];
    userRate = json['UserRate'];
    userTimesOfRates = json['UserTimesOfRates'];
    userTotalRates = json['UserTotalRates'];
    tripNumber = json['TripNumber'];
    hasTrip = json['HasTrip'];
    login = json['Login'];
    userVersion = json['UserVersion'];
    userBalance = json['UserBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UsersID'] = this.usersID;
    data['UserName'] = this.userName;
    data['UserPhone'] = this.userPhone;
    data['Password'] = this.password;
    data['Email'] = this.email;
    data['UserToken'] = this.userToken;
    data['UserFirebaseToken'] = this.userFirebaseToken;
    data['LoginType'] = this.loginType;
    data['Socialid'] = this.socialid;
    data['UserPhoto'] = this.userPhoto;
    data['UserStatus'] = this.userStatus;
    data['lastUpdatedUsers'] = this.lastUpdatedUsers;
    data['CreatedAtUser'] = this.createdAtUser;
    data['UserRate'] = this.userRate;
    data['UserTimesOfRates'] = this.userTimesOfRates;
    data['UserTotalRates'] = this.userTotalRates;
    data['TripNumber'] = this.tripNumber;
    data['HasTrip'] = this.hasTrip;
    data['Login'] = this.login;
    data['UserVersion'] = this.userVersion;
    data['UserBalance'] = this.userBalance;
    return data;
  }
}
