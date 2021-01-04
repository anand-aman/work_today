
class RequestWorker{
  String workerName;
  String workerID;
  String requestID;
  String location;
  String email;
  String phoneNo;
  String job;
  int amount;
  bool isAccepted;

  RequestWorker({this.workerName, this.workerID, this.requestID,this.phoneNo,this.email, this.job, this.location, this.amount, this.isAccepted});
}

class RequestHirer{
  String hirerName;
  String hirerID;
  String requestID;
  String location;
  String email;
  String phoneNo;
  String job;
  int amount;
  bool isAccepted;

  RequestHirer({this.hirerName, this.hirerID, this.requestID, this.job,this.email, this.phoneNo, this.location, this.amount, this.isAccepted});
}