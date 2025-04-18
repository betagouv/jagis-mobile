import 'package:app/core/question_flow/domain/cursor.dart';

abstract interface class CursorManager<T> {
  const CursorManager();
  Future<Cursor<T>> first();
  Future<Cursor<T>> previous(final Cursor<T> current);
  Future<Cursor<T>> next(final Cursor<T> current);
}
