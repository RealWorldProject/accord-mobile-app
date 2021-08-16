class Request {
  Request({
    this.proposedExchangeBook,
    this.requestedBook,
  });

  final String proposedExchangeBook;
  final String requestedBook;

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      proposedExchangeBook: json['proposedExchangeBook'],
      requestedBook: json['requestedBook'],
    );
  }

  Map<String, dynamic> toJson() => {
        'proposedExchangeBook': proposedExchangeBook,
        'requestedBook': requestedBook,
      };
}
