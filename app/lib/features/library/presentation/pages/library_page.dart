import 'package:app/features/library/presentation/bloc/library_bloc.dart';
import 'package:app/features/library/presentation/bloc/library_event.dart';
import 'package:app/features/library/presentation/bloc/library_state.dart';
import 'package:app/features/library/presentation/pages/library_view.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  static const name = 'bibliotheque';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const LibraryPage());

  @override
  Widget build(final context) => RootPage(
    body: BlocProvider(
      create: (final context) => LibraryBloc(context.read())..add(const LibraryFetchRequested()),
      child: const _View(),
    ),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocSelector<LibraryBloc, LibraryState, LibraryStatus>(
    selector: (final state) => state.status,
    builder: (final context, final state) {
      switch (state) {
        case LibraryStatus.initial:
        case LibraryStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case LibraryStatus.success:
          return const LibraryView();
      }
    },
  );
}
