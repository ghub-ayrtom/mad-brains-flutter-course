import 'package:lesson_3_homework/data/dtos/show_card_dto.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';

// Расширение для преобразования объекта передачи данных класса ShowCardDataDTO
// в объект класса модели ShowCardModel
extension ShowCardFromDTOToDomain on ShowCardDataDTO {
  ShowCardModel toDomain() {
    return ShowCardModel(
      id: id,
      title: originalTitleText?.title ?? "",
      picture: primaryImage?.picture ?? "",
      releaseDate: releaseYear?.releaseDate.toString(),
    );
  }
}
