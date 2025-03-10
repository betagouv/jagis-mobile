import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/features/questions_manager/domain/cursor_manager.dart';

class CursorManagerFromList<T> extends CursorManager<T> {
  CursorManagerFromList({required this.getList});

  Future<List<T>> Function() getList;

  @override
  Future<Cursor<T>> first() async {
    final list = await this.getList();

    return Cursor(elements: list, index: 0);
  }

  @override
  Future<Cursor<T>> previous(final Cursor<T> current) async {
    final list = await this.getList();

    return Cursor(elements: list, index: current.index - 1);
  }

  @override
  Future<Cursor<T>> next(final Cursor<T> current) async {
    final list = await this.getList();

    return Cursor(elements: list, index: current.index + 1);
  }
}
