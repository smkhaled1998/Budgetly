
abstract class Failure  {
  final String message;
  Failure(this.message);
}



class EmptyCacheFailure extends Failure {

  EmptyCacheFailure([String message = "Empty Cache Failure"]):super(message);

}


class DatabaseFailure extends Failure {
  DatabaseFailure([String message = "Database Failure"]) : super(message);
}

class UnknownFailure extends Failure {
  UnknownFailure([String message = "Unknown Failure"]) : super(message);
}