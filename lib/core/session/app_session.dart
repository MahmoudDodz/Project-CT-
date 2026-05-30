import '../../data/models/incident_model.dart';
import '../../data/models/notification_model.dart';
import '../../data/models/friend_model.dart';

class AppSession {
  static final AppSession instance = AppSession._();
  AppSession._();

  String name = '';
  String email = '';
  String role = 'citizen';

  List<IncidentModel> myReports = [];
  List<NotificationModel> myNotifications = [];
  List<FriendModel> myFriends = [];
  List<FriendModel> myFriendRequests = [];

  // Shared pool — every citizen report lands here so officers can see it
  List<IncidentModel> officerQueue = [];

  int get reportCount => myReports.length;

  void addReport(IncidentModel report) {
    myReports = [report, ...myReports];
    officerQueue = [report, ...officerQueue];
    myNotifications = [
      NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: 'Your report "${report.title}" was submitted successfully',
        type: NotificationType.info,
        timeAgo: 'Just now',
      ),
      ...myNotifications,
    ];
  }

  void clear() {
    name = '';
    email = '';
    role = 'citizen';
    myReports = [];
    myNotifications = [];
    myFriends = [];
    myFriendRequests = [];
    officerQueue = [];
  }
}
