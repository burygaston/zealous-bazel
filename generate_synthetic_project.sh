#!/bin/bash

# 1. Create Directory Structure
mkdir -p core/src/test/java/com/harness/core
mkdir -p service/src/test/java/com/harness/service
mkdir -p api/src/test/java/com/harness/api
mkdir -p data/src/test/java/com/harness/data
mkdir -p utils/src/test/java/com/harness/utils
mkdir -p integration/src/test/java/com/harness/integration
mkdir -p security/src/test/java/com/harness/security

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

# 5. Create data/BUILD.bazel
cat <<EOF > data/BUILD.bazel
[java_test(
    name = "DataTest_%d" % i,
    srcs = ["src/test/java/com/harness/data/DataTest_%d.java" % i],
    test_class = "com.harness.data.DataTest_%d" % i,
    deps = [
        "@maven//:junit_junit",
        "@maven//:com_h2database_h2",
        "@maven//:com_zaxxer_HikariCP",
        "@maven//:com_fasterxml_jackson_core_jackson_databind",
        "@maven//:com_fasterxml_jackson_core_jackson_core",
    ],
) for i in range(1, 11)]
EOF

# 6. Create utils/BUILD.bazel
cat <<EOF > utils/BUILD.bazel
[java_test(
    name = "UtilsTest_%d" % i,
    srcs = ["src/test/java/com/harness/utils/UtilsTest_%d.java" % i],
    test_class = "com.harness.utils.UtilsTest_%d" % i,
    deps = [
        "@maven//:junit_junit",
        "@maven//:commons_io_commons_io",
        "@maven//:org_slf4j_slf4j_api",
        "@maven//:org_apache_logging_log4j_log4j_core",
        "@maven//:org_apache_commons_commons_collections4",
    ],
) for i in range(1, 11)]
EOF

# 7. Create integration/BUILD.bazel
cat <<EOF > integration/BUILD.bazel
[java_test(
    name = "IntegrationTest_%d" % i,
    srcs = ["src/test/java/com/harness/integration/IntegrationTest_%d.java" % i],
    test_class = "com.harness.integration.IntegrationTest_%d" % i,
    deps = [
        "//core:CoreTest_1",
        "//service:ServiceTest_1",
        "@maven//:junit_junit",
        "@maven//:org_mockito_mockito_core",
        "@maven//:org_assertj_assertj_core",
        "@maven//:io_rest_assured_rest_assured",
    ],
) for i in range(1, 11)]
EOF

# 8. Create security/BUILD.bazel
cat <<EOF > security/BUILD.bazel
[java_test(
    name = "SecurityTest_%d" % i,
    srcs = ["src/test/java/com/harness/security/SecurityTest_%d.java" % i],
    test_class = "com.harness.security.SecurityTest_%d" % i,
    deps = [
        "@maven//:junit_junit",
        "@maven//:org_mindrot_jbcrypt",
        "@maven//:org_bitbucket_b_c_jose4j",
        "@maven//:com_google_crypto_tink_tink",
        "@maven//:org_bouncycastle_bcprov_jdk15on",
    ],
) for i in range(1, 11)]
EOF

# 9. Generate Java Test Files
generate_tests() {
    local folder=$1
    local pkg=$2
    local prefix=$3
    local count=$4
    local tests_per_file=$5
    for i in $(seq 1 $count); do
        {
            echo "package com.harness.${pkg};"
            echo "import org.junit.Test;"
            echo "import static org.junit.Assert.assertTrue;"
            echo ""
            echo "public class ${prefix}_${i} {"
            for j in $(seq 1 $tests_per_file); do
                echo "    @Test public void testMethod_${j}() { assertTrue(true); }"
            done
            echo "}"
        } > ${folder}/src/test/java/com/harness/${pkg}/${prefix}_${i}.java
    done
}

generate_tests "core" "core" "CoreTest" 5 10
generate_tests "service" "service" "ServiceTest" 5 10
generate_tests "api" "api" "ApiTest" 5 10
generate_tests "data" "data" "DataTest" 10 10
generate_tests "utils" "utils" "UtilsTest" 10 10
generate_tests "integration" "integration" "IntegrationTest" 10 10
generate_tests "security" "security" "SecurityTest" 10 10

echo "Synthetic project generated:"
echo "  - 7 modules: core, service, api, data, utils, integration, security"
echo "  - 55 test files"
echo "  - 550 tests total"
echo "  - 19 unique Maven dependencies"
