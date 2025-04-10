import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:pinput/pinput.dart';

class FnvCodeInput extends StatefulWidget {
  const FnvCodeInput({super.key, required this.initialValue, required this.onChanged});

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<FnvCodeInput> createState() => _FnvCodeInputState();
}

class _FnvCodeInputState extends State<FnvCodeInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    const width = 48.0;
    const pinTheme = PinTheme(
      width: width,
      height: width * 1.27,
      padding: EdgeInsets.only(
        /// Fix vertical alignment parce que la police Marianne est mal pris en compte par flutter
        bottom: 6,
      ),
      textStyle: DsfrTextStyle(fontSize: width * 0.68),
      decoration: BoxDecoration(
        color: Color(0xFFFBFBFB),
        border: Border.fromBorderSide(BorderSide(color: Color(0xFFB9BEBE))),
      ),
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Pinput(
        length: 6,
        defaultPinTheme: pinTheme,
        focusedPinTheme: pinTheme.copyBorderWith(border: const Border.fromBorderSide(BorderSide(color: DsfrColors.focus525))),
        onChanged: widget.onChanged,
        controller: _controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
        scrollPadding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + 130),
      ),
    );
  }
}
