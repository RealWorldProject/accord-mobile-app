class ResponseExposer<T> {
  Status status;
  String errorMessage;

  ResponseExposer.loading() : status = Status.LOADING;
  ResponseExposer.complete() : status = Status.COMPLETE;
  ResponseExposer.error(this.errorMessage) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\nMessage: $errorMessage";
  }
}

enum Status {
  LOADING,
  COMPLETE,
  ERROR,
}
