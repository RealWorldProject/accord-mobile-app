class ResponseExposer<T> {
  Status status;
  T data;
  String message;

  ResponseExposer.loading() : status = Status.LOADING;
  ResponseExposer.complete(this.data) : status = Status.COMPLETE;
  ResponseExposer.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}

enum Status {
  LOADING,
  COMPLETE,
  ERROR,
}
