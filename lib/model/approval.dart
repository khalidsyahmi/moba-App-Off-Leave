class Approval {

  final String appId;
  //FK uid
  final String approvals;
  final bool status; // false/true
  //FK SVid
  final String memo;

  Approval({ this.appId, this.approvals, this.status, this.memo });

}