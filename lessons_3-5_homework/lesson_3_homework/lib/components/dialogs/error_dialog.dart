import 'package:flutter/material.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/presentation/home/pages/home_page.dart';

// Метод вызова диалога с ошибкой
void showExceptionDialog({BuildContext? context, required String exception}) {
  // Так как диалог всегда отображается в конкретном контексте, то необходимо
  // либо передать его из определённого окна приложения, либо взять контекст
  // главного экрана приложения по глобальному статическому ключу
  final inContext = context ?? HomePage.globalKey.currentContext;

  if (inContext != null) {
    showDialog(
      context: inContext,
      builder: (_) => ExceptionDialog(exception),
    );
  }
}

// Виджет простого диалога с ошибкой
class ExceptionDialog extends StatelessWidget {
  const ExceptionDialog(this.exception, {Key? key}) : super(key: key);

  final String? exception; // Строка возникшей ошибки

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(35),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseButton(color: Colors.white),
                ],
              ),
              const Icon(
                Icons.error,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                '${Local.error} ${exception ?? Local.unknown}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
