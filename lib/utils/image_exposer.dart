class ImageExposer<T> {
  ImageStatus status;

  ImageExposer.loading() : status = ImageStatus.LOADING;
  ImageExposer.complete() : status = ImageStatus.COMPLETE;
  ImageExposer.error() : status = ImageStatus.ERROR;
  ImageExposer.noImage() : status = ImageStatus.NOIMAGE;
}

enum ImageStatus {
  LOADING,
  COMPLETE,
  ERROR,
  NOIMAGE,
}
