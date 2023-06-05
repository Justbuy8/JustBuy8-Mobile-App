part of 'upload_image_cubit.dart';


abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageUploaded extends UploadImageState {}

class UploadImageFailed extends UploadImageState {}

class UploadImageInternetError extends UploadImageState {}

class UploadImageTimeout extends UploadImageState {}
