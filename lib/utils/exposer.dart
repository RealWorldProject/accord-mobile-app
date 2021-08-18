class ResponseExposer<T> {
  Status status;
  String message;

  ResponseExposer.loading() : status = Status.LOADING;
  ResponseExposer.complete([this.message = null]) : status = Status.COMPLETE;
  ResponseExposer.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\nMessage: $message";
  }
}

enum Status {
  LOADING,
  COMPLETE,
  ERROR,
}
