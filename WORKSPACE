workspace(name = "zealous_bazel")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-5.3",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/5.3.zip",
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    name = "maven",  # This must be exactly 'maven' to use @maven//:target
    artifacts = [
        "junit:junit:4.13.2",
        "com.google.guava:guava:31.1-jre",
        "org.mockito:mockito-core:4.8.0",
        "org.apache.commons:commons-lang3:3.12.0",
        "org.slf4j:slf4j-api:1.7.36",
        "ch.qos.logback:logback-classic:1.2.11",
        "com.fasterxml.jackson.core:jackson-databind:2.13.3",
        "org.assertj:assertj-core:3.23.1",
        "joda-time:joda-time:2.10.14",
        "org.apache.httpcomponents:httpclient:4.5.13",
        "com.google.inject:guice:5.1.0",
        "io.netty:netty-all:4.1.77.Final",
        "org.springframework:spring-core:5.3.20",
        "org.hibernate:hibernate-core:5.6.9.Final",
        "com.squareup.okhttp3:okhttp:4.9.3",
    ],
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)
