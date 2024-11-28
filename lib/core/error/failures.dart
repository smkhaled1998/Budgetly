abstract class Failure {
  final String message;
  Failure(this.message);
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure({required String errorMessage})
      : super("Empty Cache Failure: $errorMessage");
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required String message }) : super(message);
}

class UnknownFailure extends Failure {
  UnknownFailure({required String errorMessage})
      : super("Unknown Failure: $errorMessage");
}

class DatabaseInitializationFailure extends Failure {
  DatabaseInitializationFailure({required String errorMessage})
      : super("Database Initialization Failure: $errorMessage");
}

class SQLSyntaxFailure extends Failure {
  SQLSyntaxFailure({required String errorMessage})
      : super("SQL Syntax Failure: $errorMessage");
}

class QueryExecutionFailure extends Failure {
  QueryExecutionFailure({required String errorMessage})
      : super("Query Execution Failure: $errorMessage");
}

class DataInsertionFailure extends Failure {
  DataInsertionFailure({required String errorMessage})
      : super("Data Insertion Failure: $errorMessage");
}

class DataUpdateFailure extends Failure {
  DataUpdateFailure({required String errorMessage})
      : super("Data Update Failure: $errorMessage");
}

class DataDeletionFailure extends Failure {
  DataDeletionFailure({required String errorMessage})
      : super("Data Deletion Failure: $errorMessage");
}

class DataRetrievalFailure extends Failure {
  DataRetrievalFailure({required String errorMessage})
      : super("Data Retrieval Failure: $errorMessage");
}
