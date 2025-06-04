// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/components/accordions/accordion.dart' as _i9;
import 'package:example/components/accordions/accordions_group.dart' as _i10;
import 'package:example/components/alert.dart' as _i2;
import 'package:example/components/autocomplete.dart' as _i3;
import 'package:example/components/callout.dart' as _i4;
import 'package:example/components/checkboxes/checkbox.dart' as _i11;
import 'package:example/components/checkboxes/checkbox_set.dart' as _i12;
import 'package:example/components/link.dart' as _i5;
import 'package:example/components/loader.dart' as _i6;
import 'package:example/components/progress_bar.dart' as _i7;
import 'package:example/components/radios_group.dart' as _i8;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'components',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'FnvAlert',
        useCase: _i1.WidgetbookUseCase(
          name: 'Error',
          builder: _i2.buildAlertUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'FnvAutocomplete',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i3.buildAutocompleteUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'FnvCallout',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i4.buildCalloutUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'FnvLink',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i5.buildLinkUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'FnvLoader',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i6.buildLoaderUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'FnvProgressBar',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i7.buildProgressBarUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'FnvRadiosGroup',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i8.buildRadiosGroupUseCase,
        ),
      ),
      _i1.WidgetbookFolder(
        name: 'accordions',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'FnvAccordion',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i9.buildAccordionUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FnvAccordionsGroup',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i10.buildAccordionsGroupUseCase,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'checkboxes',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'FnvCheckbox',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i11.buildCheckboxDefaultUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FnvCheckboxSet',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i12.buildCheckboxSetUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
];
