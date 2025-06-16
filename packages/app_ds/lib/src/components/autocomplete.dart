import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

typedef OnSearch<T> = Future<Iterable<T>> Function(String query);

class FnvAutocomplete<T extends Object> extends StatefulWidget {
  const FnvAutocomplete({
    super.key,
    this.initialValue,
    required this.displayStringForOption,
    required this.onSearch,
    required this.onSelected,
  });

  final String? initialValue;
  final String Function(T option) displayStringForOption;
  final OnSearch<T> onSearch;
  final AutocompleteOnSelected<T> onSelected;

  @override
  State<FnvAutocomplete<T>> createState() => _FnvAutocompleteState<T>();
}

class _FnvAutocompleteState<T extends Object> extends State<FnvAutocomplete<T>> {
  String? _lastQuery;
  Iterable<T> _lastOptions = <T>[];
  Timer? _timer;

  Future<Iterable<T>?> _debouncedSearch(final String query) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    final completer = Completer<Iterable<T>?>();
    _timer = Timer(Durations.long2, () async {
      try {
        if (_lastQuery == query) {
          completer.complete();
        } else {
          final options = await widget.onSearch(query);
          completer.complete(options);
        }
      } on Exception {
        completer.complete();
      }
    });

    return completer.future;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Autocomplete<T>(
    optionsBuilder: (final textEditingValue) async {
      final text = textEditingValue.text;
      if (text.isEmpty || text.length < 3) {
        return const Iterable.empty();
      }

      if (text == _lastQuery) {
        return _lastOptions;
      }

      final options = await _debouncedSearch(text);

      if (options == null) {
        return _lastOptions;
      }

      _lastQuery = text;
      _lastOptions = options;

      return options;
    },
    displayStringForOption: (final option) => widget.displayStringForOption(option),
    fieldViewBuilder: (final context, final textEditingController, final focusNode, final onFieldSubmitted) => DsfrInputHeadless(
      key: const ValueKey('autocomplete_input'),
      controller: textEditingController,
      suffixIcon: const Icon(DsfrIcons.systemSearchLine, color: DsfrColors.grey50),
      onFieldSubmitted: (final value) => onFieldSubmitted(),
      keyboardType: TextInputType.streetAddress,
      autocorrect: false,
      focusNode: focusNode,
    ),
    onSelected: (final option) {
      // Prevent unnecessary search after selection
      _lastQuery = widget.displayStringForOption(option);
      widget.onSelected(option);
    },
    optionsViewBuilder: (final context, final onSelected, final options) => Align(
      alignment: AlignmentDirectional.topStart,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [BoxShadow(color: Color(0x0D000068), offset: Offset(0, 5), blurRadius: 20)],
        ),
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (final context, final index) {
            final option = options.elementAt(index);
            final highlight = AutocompleteHighlightedOption.of(context) == index;
            if (highlight) {
              SchedulerBinding.instance.addPostFrameCallback((final timeStamp) async {
                await Scrollable.ensureVisible(context, alignment: 0.5);
              });
            }

            return InkWell(
              onTap: () => onSelected(option),
              child: ColoredBox(
                color: highlight ? DsfrColors.blueFranceSun113 : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.displayStringForOption(option),
                    style: DsfrTextStyle.bodyMd(color: highlight ? Colors.white : DsfrColors.grey50),
                  ),
                ),
              ),
            );
          },
          itemCount: options.length,
        ),
      ),
    ),
    initialValue: widget.initialValue == null ? TextEditingValue.empty : TextEditingValue(text: widget.initialValue!),
  );
}
