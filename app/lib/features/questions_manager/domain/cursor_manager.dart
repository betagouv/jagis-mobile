import 'package:app/features/questions_manager/domain/cursor.dart';

abstract class CursorManager<T> {
  const CursorManager();
  Future<Cursor<T>> first();
  Future<Cursor<T>> previous(final Cursor<T> current);
  Future<Cursor<T>> next(final Cursor<T> current);
}
