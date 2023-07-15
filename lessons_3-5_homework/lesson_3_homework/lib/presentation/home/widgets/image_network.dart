import 'package:flutter/material.dart';

// Виджет для загрузки изображений из сети
class ImageNetwork extends StatelessWidget {
  const ImageNetwork(
    this.imageUrl, {
    required this.width,
    this.height, // Высота изображения - необязательный параметр
    // cover - изображение масштабируется относительно максимальной стороны контейнера (ширины или высоты)
    this.fit = BoxFit.cover,
    super.key,
  });

  final String imageUrl;
  final double width;
  final double? height; // Может быть null
  // Данный параметр позволяет настроить расположение изображения внутри контейнера
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        // Если загрузка изображения из сети завершена
        if (loadingProgress == null) {
          // Возвращаем потомка виджета Image.network, то есть виджет изображения - Image
          return child;
        }

        // Если загрузка изображения из сети ещё не завершена
        return Center(
          child: CircularProgressIndicator(
            color: Colors.purple[300],
          ),
        );
      },
      // Если загрузить изображение из сети не удалось, то возвращаем
      // изображение-заглушку из директории assets/images проекта
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          "assets/images/404.png",
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
