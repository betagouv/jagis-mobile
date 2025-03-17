import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/domain/response_mosaic.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_bloc.dart';
import 'package:app/features/know_your_customer/detail/presentation/bloc/question_edit_event.dart';
import 'package:app/features/know_your_customer/detail/presentation/widgets/mosaic_button.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mosaic extends StatelessWidget {
  const Mosaic({super.key, required this.question});

  final QuestionMosaicBoolean question;

  @override
  Widget build(final context) => _MosaicSet(responses: question.responses);
}

class _MosaicSet extends StatefulWidget {
  const _MosaicSet({required this.responses});

  final List<ResponseMosaic> responses;

  @override
  State<_MosaicSet> createState() => _MosaicSetState();
}

class _MosaicSetState extends State<_MosaicSet> {
  List<ResponseMosaic> _responses = [];

  @override
  void initState() {
    super.initState();
    _responses = List.of(widget.responses);
  }

  @override
  Widget build(final context) => GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: DsfrSpacings.s2w,
      crossAxisSpacing: DsfrSpacings.s2w,
    ),
    itemBuilder: (final context, final index) {
      final e = _responses[index];
      const size = 40.0;

      return MosaicButton(
        emoji: FnvImage.network(e.imageUrl, width: size, height: size),
        title: e.label,
        value: e.isSelected,
        onChanged: (final value) {
          setState(() {
            _responses =
                _responses
                    .map(
                      (final r) =>
                          r.code == e.code
                              ? ResponseMosaic(
                                code: r.code,
                                label: r.label,
                                emoji: r.emoji,
                                imageUrl: r.imageUrl,
                                isSelected: value,
                              )
                              : r,
                    )
                    .toList();
          });
          context.read<QuestionEditBloc>().add(QuestionEditMosaicChangee(_responses));
        },
      );
    },
    itemCount: _responses.length,
  );
}
