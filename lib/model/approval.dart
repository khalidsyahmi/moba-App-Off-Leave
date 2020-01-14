class Approval {

  final String appId;
  //FK uid
  final String approvals; // yes/ No
  final String status; // pending/ Done
  //FK SVid
  final String memo;

  Approval({ 
    this.appId, 
    this.approvals, 
    this.status, 
    this.memo });


}