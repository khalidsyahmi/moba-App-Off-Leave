class User {

  final String uid;
  User({ this.uid });

}

class UserData {

  //leave
  final String uid;
  final String reason;
  final String date;
  final int time;

  //leaveData
  final String motive;
  final String date2;
  final String time2;

  UserData({ this.uid, this.reason, this.date, this.time, this.motive, this.date2, this.time2 });
}