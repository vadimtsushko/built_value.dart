// Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

/// Serializer for [DateTime].
///
/// An exception will be thrown on attempt to serialize local DateTime
/// instances; you must use UTC.
class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType: FullType.unspecified}) {
    if (!dateTime.isUtc) {
      throw new ArgumentError.value(
          dateTime, 'dateTime', 'Must be in utc for serialization.');
    }

    return dateTime.millisecondsSinceEpoch;
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final millisecondsSinceEpoch = serialized as int;
    return new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
        isUtc: true);
  }
}
