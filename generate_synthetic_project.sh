#!/bin/bash

# 1. Create Directory Structure
mkdir -p core/src/test/java/com/harness/core
mkdir -p service/src/test/java/com/harness/service
mkdir -p api/src/test/java/com/harness/api

# 2. Create core/BUILD.bazel
cat <<EOF > core/BUILD.bazel
[java_test(
    name = "CoreTest_%d" % i,
    srcs = ["src/test/java/com/harness/core/CoreTest_%d.java" % i],
    test_class = "com.harness.core.CoreTest_%d" % i,
    deps = [
        "@maven//:junit_junit",
        "@maven//:com_google_guava_guava",
    ],
) for i in range(1, 6)]
EOF

# 3. Create service/BUILD.bazel
cat <<EOF > service/BUILD.bazel
[java_test(
    name = "ServiceTest_%d" % i,
    srcs = ["src/test/java/com/harness/service/ServiceTest_%d.java" % i],
    test_class = "com.harness.service.ServiceTest_%d" % i,
    deps = [
        "//core:CoreTest_1", # Simulated internal dependency
        "@maven//:junit_junit",
        "@maven//:org_apache_commons_commons_lang3",
    ],
) for i in range(1, 6)]
EOF

# 4. Create api/BUILD.bazel
cat <<EOF > api/BUILD.bazel
[java_test(
    name = "ApiTest_%d" % i,
    srcs = ["src/test/java/com/harness/api/ApiTest_%d.java" % i],
    test_class = "com.harness.api.ApiTest_%d" % i,
    deps = [
        "//service:ServiceTest_1",
        "@maven//:junit_junit",
        "@maven//:com_squareup_okhttp3_okhttp",
    ],
) for i in range(1, 6)]
EOF

# 5. Generate the 15 Java Test Files (10 tests each = 150 tests)
generate_tests() {
    local folder=$1
    local pkg=$2
    local prefix=$3
    for i in {1..5}; do
        cat <<EOF > ${folder}/src/test/java/com/harness/${pkg}/${prefix}_${i}.java
package com.harness.${pkg};
import org.junit.Test;
import static org.junit.Assert.assertTrue;

public class ${prefix}_${i} {
    $(for j in {1..10}; do echo "    @Test public void testMethod_${j}() { assertTrue(true); }"; done)
}
EOF
    done
}

generate_tests "core" "core" "CoreTest"
generate_tests "service" "service" "ServiceTest"
generate_tests "api" "api" "ApiTest"

echo "Synthetic project generated with 150 tests and 15 dependencies."
