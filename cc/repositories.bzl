"""Repository rules entry point module for rules_cc."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//cc/configure:configure.bzl", "configure", "configure_toolchains")

def rules_cc_dependencies():
    _maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "2ea8a5ed2b448baf4a6855d3ce049c4c452a6470b1efd1504fdb7c1c134d220a",
        strip_prefix = "bazel-skylib-0.8.0",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/archive/0.8.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/archive/0.8.0.tar.gz",
        ],
    )


    _maybe(
        http_archive,
        name = "platforms",
        sha256 = "a07fe5e75964361885db725039c2ba673f0ee0313d971ae4f50c9b18cd28b0b5",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/platforms/archive/441afe1bfdadd6236988e9cac159df6b5a9f5a98.zip",
            "https://github.com/bazelbuild/platforms/archive/441afe1bfdadd6236988e9cac159df6b5a9f5a98.zip",
            ],
        strip_prefix = "platforms-441afe1bfdadd6236988e9cac159df6b5a9f5a98",
    )

def cc_configure(name = "local_config_cc"):
    """Rule that automatically detect the host C++ toolchain."""
    configure_toolchains(name = name + "_toolchains")
    configure(name = name)
    native.register_toolchains("@" + name + "_toolchains//:all")

def _maybe(repo_rule, name, **kwargs):
    if not native.existing_rule(name):
        repo_rule(name = name, **kwargs)
