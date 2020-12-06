
class RequestWorker{
  String workerName;
  String workerID;
  String requestID;
  String location;
  String job;
  int amount;
  bool isAccepted;

  RequestWorker({this.workerName, this.workerID, this.requestID, this.job, this.location, this.amount, this.isAccepted});
}

class RequestHirer{
  String hirerName;
  String hirerID;
  String requestID;
  String location;
  String job;
  int amount;
  bool isAccepted;

  RequestHirer({this.hirerName, this.hirerID, this.requestID, this.job, this.location, this.amount, this.isAccepted});
}