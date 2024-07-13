abstract class Failure {
  final String message;
  Failure(this.message);
}

class EmptyCacheFailure extends Failure {
  final String errorMessage;
  EmptyCacheFailure({required this.errorMessage}) : super("Empty Cache Failure: $errorMessage");
}

class DatabaseFailure extends Failure {
  DatabaseFailure([super.message = "Database Failure"]);
}

class UnknownFailure extends Failure {
  final String errorMessage;
  UnknownFailure({required this.errorMessage}) : super("Unknown Failure: $errorMessage");
}

class DatabaseInitializationFailure extends Failure {
  final String errorMessage;
  DatabaseInitializationFailure({required this.errorMessage}) : super("Database Initialization Failure: $errorMessage");
}

class SQLSyntaxFailure extends Failure {
  final String errorMessage;
  SQLSyntaxFailure({required this.errorMessage}) : super("SQL Syntax Failure: $errorMessage");
}

class QueryExecutionFailure extends Failure {
  final String errorMessage;
  QueryExecutionFailure({required this.errorMessage}) : super("Query Execution Failure: $errorMessage");
}

class DataInsertionFailure extends Failure {
  final String errorMessage;
  DataInsertionFailure({required this.errorMessage}) : super("Data Insertion Failure: $errorMessage");
}

class DataUpdateFailure extends Failure {
  final String errorMessage;
  DataUpdateFailure({required this.errorMessage}) : super("Data Update Failure: $errorMessage");
}

class DataDeletionFailure extends Failure {
  final String errorMessage;
  DataDeletionFailure({required this.errorMessage}) : super("Data Deletion Failure: $errorMessage");
}

class DataRetrievalFailure extends Failure {
  final String errorMessage;
  DataRetrievalFailure({required this.errorMessage}) : super("Data Retrieval Failure: $errorMessage");
}
