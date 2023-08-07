// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'template.dart';

class ButtonTemplate extends TokenTemplate {
<<<<<<< HEAD
  const ButtonTemplate(this.tokenGroup, String fileName, Map<String, dynamic> tokens)
    : super(fileName, tokens,
        colorSchemePrefix: '_colors.',
      );
=======
  const ButtonTemplate(this.tokenGroup, super.blockName, super.fileName, super.tokens, {
    super.colorSchemePrefix = '_colors.',
  });
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8

  final String tokenGroup;

  String _backgroundColor() {
    if (tokens.containsKey('$tokenGroup.container.color')) {
      return '''

    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
<<<<<<< HEAD
      if (states.contains(MaterialState.disabled))
        return ${componentColor('$tokenGroup.disabled.container')};
=======
      if (states.contains(MaterialState.disabled)) {
        return ${componentColor('$tokenGroup.disabled.container')};
      }
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
      return ${componentColor('$tokenGroup.container')};
    })''';
    }
    return '''

<<<<<<< HEAD
    ButtonStyleButton.allOrNull<Color>(Colors.transparent)''';
=======
    const MaterialStatePropertyAll<Color>(Colors.transparent)''';
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
  }

  String _elevation() {
    if (tokens.containsKey('$tokenGroup.container.elevation')) {
      return '''

    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
<<<<<<< HEAD
      if (states.contains(MaterialState.disabled))
        return ${elevation("$tokenGroup.disabled.container")};
      if (states.contains(MaterialState.hovered))
        return ${elevation("$tokenGroup.hover.container")};
      if (states.contains(MaterialState.focused))
        return ${elevation("$tokenGroup.focus.container")};
      if (states.contains(MaterialState.pressed))
        return ${elevation("$tokenGroup.pressed.container")};
=======
      if (states.contains(MaterialState.disabled)) {
        return ${elevation("$tokenGroup.disabled.container")};
      }
      if (states.contains(MaterialState.hovered)) {
        return ${elevation("$tokenGroup.hover.container")};
      }
      if (states.contains(MaterialState.focused)) {
        return ${elevation("$tokenGroup.focus.container")};
      }
      if (states.contains(MaterialState.pressed)) {
        return ${elevation("$tokenGroup.pressed.container")};
      }
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
      return ${elevation("$tokenGroup.container")};
    })''';
    }
    return '''

<<<<<<< HEAD
    ButtonStyleButton.allOrNull<double>(0.0)''';
=======
    const MaterialStatePropertyAll<double>(0.0)''';
  }

  String _elevationColor(String token) {
    if (tokens.containsKey(token)) {
      return 'MaterialStatePropertyAll<Color>(${color(token)})';
    } else {
      return 'const MaterialStatePropertyAll<Color>(Colors.transparent)';
    }
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
  }

  @override
  String generate() => '''
<<<<<<< HEAD
// Generated version ${tokens["version"]}
class _TokenDefaultsM3 extends ButtonStyle {
  _TokenDefaultsM3(this.context)
=======
class _${blockName}DefaultsM3 extends ButtonStyle {
  _${blockName}DefaultsM3(this.context)
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
   : super(
       animationDuration: kThemeChangeDuration,
       enableFeedback: true,
       alignment: Alignment.center,
     );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  MaterialStateProperty<TextStyle?> get textStyle =>
<<<<<<< HEAD
    MaterialStateProperty.all<TextStyle?>(${textStyle("$tokenGroup.label-text")});
=======
    MaterialStatePropertyAll<TextStyle?>(${textStyle("$tokenGroup.label-text")});
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8

  @override
  MaterialStateProperty<Color?>? get backgroundColor =>${_backgroundColor()};

  @override
  MaterialStateProperty<Color?>? get foregroundColor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
<<<<<<< HEAD
      if (states.contains(MaterialState.disabled))
        return ${componentColor('$tokenGroup.disabled.label-text')};
=======
      if (states.contains(MaterialState.disabled)) {
        return ${componentColor('$tokenGroup.disabled.label-text')};
      }
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
      return ${componentColor('$tokenGroup.label-text')};
    });

  @override
  MaterialStateProperty<Color?>? get overlayColor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
<<<<<<< HEAD
      if (states.contains(MaterialState.hovered))
        return ${componentColor('$tokenGroup.hover.state-layer')};
      if (states.contains(MaterialState.focused))
        return ${componentColor('$tokenGroup.focus.state-layer')};
      if (states.contains(MaterialState.pressed))
        return ${componentColor('$tokenGroup.pressed.state-layer')};
      return null;
    });

${tokens.containsKey("$tokenGroup.container.shadow-color") ? '''
  @override
  MaterialStateProperty<Color>? get shadowColor =>
    ButtonStyleButton.allOrNull<Color>(${color("$tokenGroup.container.shadow-color")});''' : '''
  // No default shadow color'''}

${tokens.containsKey("$tokenGroup.container.surface-tint-layer.color") ? '''
  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
    ButtonStyleButton.allOrNull<Color>(${color("$tokenGroup.container.surface-tint-layer.color")});''' : '''
  // No default surface tint color'''}
=======
      if (states.contains(MaterialState.hovered)) {
        return ${componentColor('$tokenGroup.hover.state-layer')};
      }
      if (states.contains(MaterialState.focused)) {
        return ${componentColor('$tokenGroup.focus.state-layer')};
      }
      if (states.contains(MaterialState.pressed)) {
        return ${componentColor('$tokenGroup.pressed.state-layer')};
      }
      return null;
    });

  @override
  MaterialStateProperty<Color>? get shadowColor =>
    ${_elevationColor("$tokenGroup.container.shadow-color")};

  @override
  MaterialStateProperty<Color>? get surfaceTintColor =>
    ${_elevationColor("$tokenGroup.container.surface-tint-layer.color")};
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8

  @override
  MaterialStateProperty<double>? get elevation =>${_elevation()};

  @override
  MaterialStateProperty<EdgeInsetsGeometry>? get padding =>
<<<<<<< HEAD
    ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
    ButtonStyleButton.allOrNull<Size>(const Size(64.0, ${tokens["$tokenGroup.container.height"]}));
=======
    MaterialStatePropertyAll<EdgeInsetsGeometry>(_scaledPadding(context));

  @override
  MaterialStateProperty<Size>? get minimumSize =>
    const MaterialStatePropertyAll<Size>(Size(64.0, ${tokens["$tokenGroup.container.height"]}));
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8

  // No default fixedSize

  @override
  MaterialStateProperty<Size>? get maximumSize =>
<<<<<<< HEAD
    ButtonStyleButton.allOrNull<Size>(Size.infinite);
=======
    const MaterialStatePropertyAll<Size>(Size.infinite);
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8

${tokens.containsKey("$tokenGroup.outline.color") ? '''
  @override
  MaterialStateProperty<BorderSide>? get side =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
<<<<<<< HEAD
    if (states.contains(MaterialState.disabled))
      return ${border("$tokenGroup.disabled.outline")};
=======
    if (states.contains(MaterialState.disabled)) {
      return ${border("$tokenGroup.disabled.outline")};
    }
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
    return ${border("$tokenGroup.outline")};
  });''' : '''
  // No default side'''}

  @override
  MaterialStateProperty<OutlinedBorder>? get shape =>
<<<<<<< HEAD
    ButtonStyleButton.allOrNull<OutlinedBorder>(${shape("$tokenGroup.container")});
=======
    const MaterialStatePropertyAll<OutlinedBorder>(${shape("$tokenGroup.container", '')});
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8

  @override
  MaterialStateProperty<MouseCursor?>? get mouseCursor =>
    MaterialStateProperty.resolveWith((Set<MaterialState> states) {
<<<<<<< HEAD
      if (states.contains(MaterialState.disabled))
        return SystemMouseCursors.basic;
=======
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.basic;
      }
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
      return SystemMouseCursors.click;
    });

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize => Theme.of(context).materialTapTargetSize;

  @override
  InteractiveInkFeatureFactory? get splashFactory => Theme.of(context).splashFactory;
}
''';
}
