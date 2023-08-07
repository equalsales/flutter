// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

abstract class TokenTemplate {
  const TokenTemplate(this.blockName, this.fileName, this.tokens, {
    this.colorSchemePrefix = 'Theme.of(context).colorScheme.',
    this.textThemePrefix = 'Theme.of(context).textTheme.'
  });

  /// Name of the code block that this template will generate.
  ///
  /// Used to identify an existing block when updating it.
  final String blockName;

  /// Name of the file that will be updated with the generated code.
  final String fileName;

  /// Map of token data extracted from the Material Design token database.
  final Map<String, dynamic> tokens;

  /// Optional prefix prepended to color definitions.
  ///
  /// Defaults to 'Theme.of(context).colorScheme.'
  final String colorSchemePrefix;

  /// Optional prefix prepended to text style definitions.
  ///
  /// Defaults to 'Theme.of(context).textTheme.'
  final String textThemePrefix;

  static const String beginGeneratedComment = '''

// BEGIN GENERATED TOKEN PROPERTIES''';

  static const String headerComment = '''

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

''';

  static const String endGeneratedComment = '''

// END GENERATED TOKEN PROPERTIES''';

  /// Replace or append the contents of the file with the text from [generate].
  ///
  /// If the file already contains a generated text block matching the
  /// [blockName], it will be replaced by the [generate] output. Otherwise
  /// the content will just be appended to the end of the file.
  Future<void> updateFile() async {
    final String contents = File(fileName).readAsStringSync();
    final String beginComment = '$beginGeneratedComment - $blockName\n';
    final String endComment = '$endGeneratedComment - $blockName\n';
    final int beginPreviousBlock = contents.indexOf(beginComment);
    final int endPreviousBlock = contents.indexOf(endComment);
    late String contentBeforeBlock;
    late String contentAfterBlock;
    if (beginPreviousBlock != -1) {
      if (endPreviousBlock < beginPreviousBlock) {
        print('Unable to find block named $blockName in $fileName, skipping code generation.');
        return;
      }
      // Found a valid block matching the name, so record the content before and after.
      contentBeforeBlock = contents.substring(0, beginPreviousBlock);
      contentAfterBlock = contents.substring(endPreviousBlock + endComment.length);
    } else {
      // Just append to the bottom.
      contentBeforeBlock = contents;
      contentAfterBlock = '';
    }

    final StringBuffer buffer = StringBuffer(contentBeforeBlock);
    buffer.write(beginComment);
    buffer.write(headerComment);
    buffer.write('// Token database version: ${tokens['version']}\n\n');
    buffer.write(generate());
    buffer.write(endComment);
    buffer.write(contentAfterBlock);
    File(fileName).writeAsStringSync(buffer.toString());
  }

  /// Provide the generated content for the template.
  ///
  /// This abstract method needs to be implemented by subclasses
  /// to provide the content that [updateFile] will append to the
  /// bottom of the file.
  String generate();

  /// Generate a [ColorScheme] color name for the given token.
  ///
  /// If there is a value for the given token, this will return
  /// the value prepended with [colorSchemePrefix].
  ///
  /// Otherwise it will return [defaultValue].
  ///
  /// See also:
  ///   * [componentColor], that provides support for an optional opacity.
  String color(String colorToken, [String defaultValue = 'null']) {
    return tokens.containsKey(colorToken)
      ? '$colorSchemePrefix${tokens[colorToken]}'
<<<<<<< HEAD
      : 'null';
=======
      : defaultValue;
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
  }

  /// Generate a [ColorScheme] color name for the given token or a transparent
  /// color if there is no value for the token.
  ///
  /// If there is a value for the given token, this will return
  /// the value prepended with [colorSchemePrefix].
  ///
  /// Otherwise it will return 'Colors.transparent'.
  ///
  /// See also:
  ///   * [componentColor], that provides support for an optional opacity.
  String? colorOrTransparent(String token) => color(token, 'Colors.transparent');

  /// Generate a [ColorScheme] color name for the given component's color
  /// with opacity if available.
  ///
  /// If there is a value for the given component's color, this will return
  /// the value prepended with [colorSchemePrefix]. If there is also
  /// an opacity specified for the component, then the returned value
  /// will include this opacity calculation.
  ///
  /// If there is no value for the component's color, 'null' will be returned.
  ///
  /// See also:
  ///   * [color], that provides support for looking up a raw color token.
  String componentColor(String componentToken) {
    final String colorToken = '$componentToken.color';
    if (!tokens.containsKey(colorToken)) {
      return 'null';
    }
    String value = color(colorToken);
    final String opacityToken = '$componentToken.opacity';
    if (tokens.containsKey(opacityToken)) {
      value += '.withOpacity(${opacity(opacityToken)})';
    }
    return value;
  }

  /// Generate the opacity value for the given token.
<<<<<<< HEAD
  String? opacity(String token) {
    final dynamic value = tokens[token];
    if (value == null) {
      return null;
    }
    if (value is double) {
      return value.toString();
=======
  String? opacity(String token) => _numToString(tokens[token]);

  String? _numToString(Object? value, [int? digits]) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      if (value == double.infinity) {
        return 'double.infinity';
      }
      return digits == null ? value.toString() : value.toStringAsFixed(digits);
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
    }
    return tokens[value].toString();
  }

  /// Generate an elevation value for the given component token.
  String elevation(String componentToken) {
    return tokens[tokens['$componentToken.elevation']!]!.toString();
  }

  /// Generate a size value for the given component token.
  ///
  /// Non-square sizes are specified as width and height.
  String size(String componentToken) {
    final String sizeToken = '$componentToken.size';
    if (!tokens.containsKey(sizeToken)) {
      final String widthToken = '$componentToken.width';
      final String heightToken = '$componentToken.height';
      if (!tokens.containsKey(widthToken) && !tokens.containsKey(heightToken)) {
        throw Exception('Unable to find width, height, or size tokens for $componentToken');
      }
      final String? width = _numToString(tokens.containsKey(widthToken) ? tokens[widthToken]! as num : double.infinity, 0);
      final String? height = _numToString(tokens.containsKey(heightToken) ? tokens[heightToken]! as num : double.infinity, 0);
      return 'const Size($width, $height)';
    }
    return 'const Size.square(${_numToString(tokens[sizeToken])})';
  }

  /// Generate a shape constant for the given component token.
  ///
  /// Currently supports family:
  ///   - "SHAPE_FAMILY_ROUNDED_CORNERS" which maps to [RoundedRectangleBorder].
  ///   - "SHAPE_FAMILY_CIRCULAR" which maps to a [StadiumBorder].
  String shape(String componentToken, [String prefix = 'const ']) {
    final Map<String, dynamic> shape = tokens[tokens['$componentToken.shape']!]! as Map<String, dynamic>;
    switch (shape['family']) {
      case 'SHAPE_FAMILY_ROUNDED_CORNERS':
        final double topLeft = shape['topLeft'] as double;
        final double topRight = shape['topRight'] as double;
        final double bottomLeft = shape['bottomLeft'] as double;
        final double bottomRight = shape['bottomRight'] as double;
        if (topLeft == topRight && topLeft == bottomLeft && topLeft == bottomRight) {
          if (topLeft == 0) {
            return '${prefix}RoundedRectangleBorder()';
          }
          return '${prefix}RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular($topLeft)))';
        }
        if (topLeft == topRight && bottomLeft == bottomRight) {
          return '${prefix}RoundedRectangleBorder(borderRadius: BorderRadius.vertical('
            '${topLeft > 0 ? 'top: Radius.circular($topLeft)':''}'
            '${topLeft > 0 && bottomLeft > 0 ? ',':''}'
            '${bottomLeft > 0 ? 'bottom: Radius.circular($bottomLeft)':''}'
            '))';
        }
        return '${prefix}RoundedRectangleBorder(borderRadius: '
          'BorderRadius.only('
          'topLeft: Radius.circular(${shape['topLeft']}), '
          'topRight: Radius.circular(${shape['topRight']}), '
          'bottomLeft: Radius.circular(${shape['bottomLeft']}), '
          'bottomRight: Radius.circular(${shape['bottomRight']})))';
    case 'SHAPE_FAMILY_CIRCULAR':
        return '${prefix}StadiumBorder()';
    }
    print('Unsupported shape family type: ${shape['family']} for $componentToken');
    return '';
  }

  /// Generate a [BorderSide] for the given component.
  String border(String componentToken) {
    if (!tokens.containsKey('$componentToken.color')) {
      return 'null';
    }
    final String borderColor = componentColor(componentToken);
<<<<<<< HEAD
    final double width = (tokens['$componentToken.width'] ?? 1.0) as double;
=======
    final double width = (tokens['$componentToken.width'] ?? tokens['$componentToken.height'] ?? 1.0) as double;
>>>>>>> f468f3366c26a5092eb964a230ce7892fda8f2f8
    return 'BorderSide(color: $borderColor${width != 1.0 ? ", width: $width" : ""})';
  }

  /// Generate a [TextTheme] text style name for the given component token.
  String textStyle(String componentToken) {
    return '$textThemePrefix${tokens["$componentToken.text-style"]}';
  }

  String textStyleWithColor(String componentToken) {
    if (!tokens.containsKey('$componentToken.text-style')) {
      return 'null';
    }
    String style = textStyle(componentToken);
    if (tokens.containsKey('$componentToken.color')) {
      style = '$style?.copyWith(color: ${componentColor(componentToken)})';
    }
    return style;
  }
}
