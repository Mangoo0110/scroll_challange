import 'dart:typed_data';

class UpdateImageParam {
  String? imageUrl;
  Uint8List imageBytes;
  UpdateImageParam.update({required String this.imageUrl, required this.imageBytes});

  UpdateImageParam.upload({required this.imageBytes});

}
