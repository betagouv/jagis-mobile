// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/components/accordions/accordion.dart'
    as _example_components_accordions_accordion;
import 'package:example/components/accordions/accordions_group.dart'
    as _example_components_accordions_accordions_group;
import 'package:example/components/alert.dart' as _example_components_alert;
import 'package:example/components/autocomplete.dart'
    as _example_components_autocomplete;
import 'package:example/components/block_quote.dart'
    as _example_components_block_quote;
import 'package:example/components/callout.dart' as _example_components_callout;
import 'package:example/components/charts/doughnut_chart.dart'
    as _example_components_charts_doughnut_chart;
import 'package:example/components/checkboxes/checkbox.dart'
    as _example_components_checkboxes_checkbox;
import 'package:example/components/checkboxes/checkbox_set.dart'
    as _example_components_checkboxes_checkbox_set;
import 'package:example/components/date_only_input.dart'
    as _example_components_date_only_input;
import 'package:example/components/link.dart' as _example_components_link;
import 'package:example/components/loader.dart' as _example_components_loader;
import 'package:example/components/progress_bar.dart'
    as _example_components_progress_bar;
import 'package:example/components/radios_group.dart'
    as _example_components_radios_group;
import 'package:example/components/stepper.dart' as _example_components_stepper;
import 'package:example/components/toggle_switch.dart'
    as _example_components_toggle_switch;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'components',
    children: [
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvAlert',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Error',
          builder: _example_components_alert.buildAlertUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvAutocomplete',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_autocomplete.buildAutocompleteUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvBlockQuote',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_block_quote.buildBlockQuoteUseCase,
          designLink:
              'https://www.figma.com/design/CqHGLfk0uIdy61mDdZN0hv/J-agis-2025?node-id=17165-413000&t=fehBWDhYBNKlBsVt-4',
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvCallout',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_callout.buildCalloutUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvDateOnlyInput',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder:
              _example_components_date_only_input.buildDateOnlyInputUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvLink',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_link.buildLinkUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvLoader',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_loader.buildLoaderUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvProgressBar',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_progress_bar.buildProgressBarUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvRadiosGroup',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_radios_group.buildRadiosGroupUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvStepper',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_stepper.buildUseCase,
        ),
      ),
      _widgetbook.WidgetbookLeafComponent(
        name: 'FnvToggleSwitch',
        useCase: _widgetbook.WidgetbookUseCase(
          name: 'Default',
          builder: _example_components_toggle_switch.buildToggleSwitchUseCase,
        ),
      ),
      _widgetbook.WidgetbookFolder(
        name: 'accordions',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'FnvAccordion',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'Default',
              builder: _example_components_accordions_accordion
                  .buildAccordionUseCase,
            ),
          ),
          _widgetbook.WidgetbookLeafComponent(
            name: 'FnvAccordionsGroup',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'Default',
              builder: _example_components_accordions_accordions_group
                  .buildAccordionsGroupUseCase,
            ),
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'charts',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'FnvDoughnutChart',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'Default',
              builder: _example_components_charts_doughnut_chart
                  .buildDoughnutChartUseCase,
            ),
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'checkboxes',
        children: [
          _widgetbook.WidgetbookLeafComponent(
            name: 'FnvCheckbox',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'Default',
              builder: _example_components_checkboxes_checkbox
                  .buildCheckboxDefaultUseCase,
            ),
          ),
          _widgetbook.WidgetbookLeafComponent(
            name: 'FnvCheckboxSet',
            useCase: _widgetbook.WidgetbookUseCase(
              name: 'Default',
              builder: _example_components_checkboxes_checkbox_set
                  .buildCheckboxSetUseCase,
            ),
          ),
        ],
      ),
    ],
  ),
];
