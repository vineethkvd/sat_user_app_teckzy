class NotificationModel {
  bool? status;
  String? msg;
  List<UserNotifications>? userNotifications;

  NotificationModel({this.status, this.msg, this.userNotifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['user_notifications'] != null) {
      userNotifications = <UserNotifications>[];
      json['user_notifications'].forEach((v) {
        userNotifications!.add(new UserNotifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.userNotifications != null) {
      data['user_notifications'] =
          this.userNotifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserNotifications {
  String? userNotifiId;
  String? msgForUser;
  String? userNotifiTime;

  UserNotifications({this.userNotifiId, this.msgForUser, this.userNotifiTime});

  UserNotifications.fromJson(Map<String, dynamic> json) {
    userNotifiId = json['user_notifi_id'];
    msgForUser = json['msg_for_user'];
    userNotifiTime = json['user_notifi_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_notifi_id'] = this.userNotifiId;
    data['msg_for_user'] = this.msgForUser;
    data['user_notifi_time'] = this.userNotifiTime;
    return data;
  }
}
