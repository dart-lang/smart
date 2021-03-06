// Copyright (c) 2015, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE.md file.

/// This provides helpers for systematically extracting the structures used
/// for completion from the different ASTs
library smart.completion_models.ast_extractors;

import 'package:analyzer/src/generated/ast.dart' as ast;

import 'ast_features.dart';
import 'feature_vector.dart';

FeatureVector featuresFromPrefixedIdentifier(ast.PrefixedIdentifier node) {
  // TODO(lukechurch): Address the below from the completion logic:
  // "some PrefixedIdentifier nodes are transformed into
  // ConstructorName nodes during the resolution process."

  var realTarget = node.prefix;
  var completion = node.identifier;

  if (realTarget != null) {
    var invocation = extractFeaturesForTarget(realTarget, node);
    invocation.completion = completion;
    return invocation;
  }

  return null;
}

FeatureVector featuresFromPropertyAccess(ast.PropertyAccess node) {
  var realTarget = node.realTarget;
  var completion = node.propertyName;

  if (realTarget != null) {
    var invocation = extractFeaturesForTarget(realTarget, node);
    invocation.completion = completion;
    return invocation;
  }

  return null;
}

FeatureVector featuresFromMethodInvocation(ast.MethodInvocation node) {
  var realTarget = node.realTarget;
  var completion = node.methodName;

  if (realTarget != null) {
    var invocation = extractFeaturesForTarget(realTarget, node);
    invocation.completion = completion;
    return invocation;
  }

  return null;
}
