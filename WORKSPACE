workspace(name = "zealous_bazel")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Rules for downloading Maven artifacts
http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-5.3",
    sha256 = "6cc8444b20307113a62b676846c29ff018f0e24d0b7e8a9c10a9a0476c4d2c85",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/5.3.zip",
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        # Testing
        "junit:junit:4.13.2",
        "org.mockito:mockito-core:4.8.0",
        "org.assertj:assertj-core:3.24.2",
        "io.rest-assured:rest-assured:5.3.0",

        # Core utilities
        "com.google.guava:guava:31.1-jre",
        "org.apache.commons:commons-lang3:3.12.0",
        "commons-io:commons-io:2.11.0",
        "org.apache.commons:commons-collections4:4.4",

        # HTTP
        "com.squareup.okhttp3:okhttp:4.10.0",

        # Database
        "com.h2database:h2:2.1.214",
        "com.zaxxer:HikariCP:5.0.1",

        # JSON
        "com.fasterxml.jackson.core:jackson-databind:2.14.2",
        "com.fasterxml.jackson.core:jackson-core:2.14.2",

        # Logging
        "org.slf4j:slf4j-api:2.0.6",
        "org.apache.logging.log4j:log4j-core:2.19.0",

        # Security
        "org.mindrot:jbcrypt:0.4",
        "org.bitbucket.b_c:jose4j:0.9.3",
        "com.google.crypto.tink:tink:1.7.0",
        "org.bouncycastle:bcprov-jdk15on:1.70",
    ],
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)
