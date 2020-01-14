class User {

  final String uid;
  User({ this.uid });

}

// to databaseservices => add all other model datatypes her as well
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

  //profile
  // final String name;
  final String color;

  //Approval
  final String appId;
  final String approvals; 
  final String status; 
  final String memo;

  //Creds
  final String name;
  final String email;
  final String password;


  UserData({ 
  this.uid, this.reason, this.date, this.time, 
  this.motive, this.date2, this.time2,
  this.color, this.name, 
  this.appId, this.approvals, this.status, this.memo,
  this.email, this.password
  
  });
}