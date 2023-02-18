const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const http_parser_dep = b.dependency("http_parser", .{
        .target = target,
        .optimize = optimize,
    });

    const libz_dep = b.dependency("libz", .{
        .target = target,
        .optimize = optimize,
    });

    const pcre_dep = b.dependency("pcre", .{
        .target = target,
        .optimize = optimize,
    });

    const libgitz = b.addStaticLibrary(.{
        .name = "gitz",
        .target = target,
        .optimize = optimize,
    });

    libgitz.linkLibrary(http_parser_dep.artifact("http_parser"));
    libgitz.linkLibrary(libz_dep.artifact("z"));
    libgitz.linkLibrary(pcre_dep.artifact("pcre"));

    const features_h = b.addConfigHeader(.{
        .style = .{ .cmake = .{ .path = "src/util/git2_features.h.in" } }
    }, .{
        .GIT_DEBUG_POOL = null,
        .GIT_DEBUG_STRICT_ALLOC = null,
        .GIT_DEBUG_STRICT_OPEN = null,

        .GIT_THREADS = 1,
        .GIT_WIN32_LEAKCHECK = null,

        .GIT_ARCH_64 = 1,
        .GIT_ARCH_32 = null,

        .GIT_USE_ICONV = null,
        .GIT_USE_NSEC = null,
        .GIT_USE_STAT_MTIM = 1,
        .GIT_USE_STAT_MTIMESPEC = null,
        .GIT_USE_STAT_MTIME_NSEC = null,
        .GIT_USE_FUTIMENS = 1,

        .GIT_REGEX_REGCOMP_L = null,
        .GIT_REGEX_REGCOMP = null,
        .GIT_REGEX_PCRE = 1,
        .GIT_REGEX_PCRE2 = null,
        .GIT_REGEX_BUILTIN = null,

        .GIT_QSORT_R_BSD = null,
        .GIT_QSORT_R_GNU = 1,
        .GIT_QSORT_S = null,

        .GIT_SSH = null,
        .GIT_SSH_MEMORY_CREDENTIALS = null,

        .GIT_NTLM = null,
        .GIT_GSSAPI = null,
        .GIT_GSSFRAMEWORK = null,

        .GIT_WINHTTP = null,
        .GIT_HTTPS = 1,
        .GIT_OPENSSL = 1,
        .GIT_OPENSSL_DYNAMIC = null,
        .GIT_SECURE_TRANSPORT = null,
        .GIT_MBEDTLS = null,

        .GIT_SHA1_COLLISIONDETECT = null,
        .GIT_SHA1_WIN32 = null,
        .GIT_SHA1_COMMON_CRYPTO = null,
        .GIT_SHA1_OPENSSL = 1,
        .GIT_SHA1_OPENSSL_DYNAMIC = null,
        .GIT_SHA1_MBEDTLS = null,

        .GIT_SHA256_BUILTIN = null,
        .GIT_SHA256_WIN32 = null,
        .GIT_SHA256_COMMON_CRYPTO = null,
        .GIT_SHA256_OPENSSL = 1,
        .GIT_SHA256_OPENSSL_DYNAMIC = null,
        .GIT_SHA256_MBEDTLS = null,

        .GIT_RAND_GETENTROPY = 1,
        .GIT_RAND_GETLOADAVG = 1,
    });

    libgitz.addConfigHeader(features_h);
    libgitz.linkLibC();
    libgitz.addIncludePath("./src/util");
    libgitz.addIncludePath("./src/include");
    libgitz.addIncludePath("./src/include/git2");
    libgitz.addIncludePath("./src/libgit2");
    libgitz.addIncludePath("./include");
    libgitz.addCSourceFiles(&.{
        "src/libgit2/annotated_commit.c",
        "src/libgit2/apply.c",
        "src/libgit2/attr.c",
        "src/libgit2/attrcache.c",
        "src/libgit2/attr_file.c",
        "src/libgit2/blame.c",
        "src/libgit2/blame_git.c",
        "src/libgit2/blob.c",
        "src/libgit2/branch.c",
        "src/libgit2/buf.c",
        "src/libgit2/cache.c",
        "src/libgit2/checkout.c",
        "src/libgit2/cherrypick.c",
        "src/libgit2/clone.c",
        "src/libgit2/commit.c",
        "src/libgit2/commit_graph.c",
        "src/libgit2/commit_list.c",
        "src/libgit2/config.c",
        "src/libgit2/config_cache.c",
        "src/libgit2/config_entries.c",
        "src/libgit2/config_file.c",
        "src/libgit2/config_mem.c",
        "src/libgit2/config_parse.c",
        "src/libgit2/config_snapshot.c",
        "src/libgit2/crlf.c",
        "src/libgit2/delta.c",
        "src/libgit2/describe.c",
        "src/libgit2/diff.c",
        "src/libgit2/diff_driver.c",
        "src/libgit2/diff_file.c",
        "src/libgit2/diff_generate.c",
        "src/libgit2/diff_parse.c",
        "src/libgit2/diff_print.c",
        "src/libgit2/diff_stats.c",
        "src/libgit2/diff_tform.c",
        "src/libgit2/diff_xdiff.c",
        "src/libgit2/email.c",
        "src/libgit2/errors.c",
        "src/libgit2/fetch.c",
        "src/libgit2/fetchhead.c",
        "src/libgit2/filter.c",
        "src/libgit2/graph.c",
        "src/libgit2/hashsig.c",
        "src/libgit2/ident.c",
        "src/libgit2/idxmap.c",
        "src/libgit2/ignore.c",
        "src/libgit2/index.c",
        "src/libgit2/indexer.c",
        "src/libgit2/iterator.c",
        "src/libgit2/libgit2.c",
        "src/libgit2/mailmap.c",
        "src/libgit2/merge.c",
        "src/libgit2/merge_driver.c",
        "src/libgit2/merge_file.c",
        "src/libgit2/message.c",
        "src/libgit2/midx.c",
        "src/libgit2/mwindow.c",
        "src/libgit2/netops.c",
        "src/libgit2/notes.c",
        "src/libgit2/object_api.c",
        "src/libgit2/object.c",
        "src/libgit2/odb.c",
        "src/libgit2/odb_loose.c",
        "src/libgit2/odb_mempack.c",
        "src/libgit2/odb_pack.c",
        "src/libgit2/offmap.c",
        "src/libgit2/oidarray.c",
        "src/libgit2/oid.c",
        "src/libgit2/oidmap.c",
        "src/libgit2/pack.c",
        "src/libgit2/pack-objects.c",
        "src/libgit2/parse.c",
        "src/libgit2/patch.c",
        "src/libgit2/patch_generate.c",
        "src/libgit2/patch_parse.c",
        "src/libgit2/path.c",
        "src/libgit2/pathspec.c",
        "src/libgit2/proxy.c",
        "src/libgit2/push.c",
        "src/libgit2/reader.c",
        "src/libgit2/rebase.c",
        "src/libgit2/refdb.c",
        "src/libgit2/refdb_fs.c",
        "src/libgit2/reflog.c",
        "src/libgit2/refs.c",
        "src/libgit2/refspec.c",
        "src/libgit2/remote.c",
        "src/libgit2/repository.c",
        "src/libgit2/reset.c",
        "src/libgit2/revert.c",
        "src/libgit2/revparse.c",
        "src/libgit2/revwalk.c",
        "src/libgit2/signature.c",
        "src/libgit2/stash.c",
        "src/libgit2/status.c",
        "src/libgit2/strarray.c",
        "src/libgit2/submodule.c",
        "src/libgit2/sysdir.c",
        "src/libgit2/tag.c",
        "src/libgit2/threadstate.c",
        "src/libgit2/trace.c",
        "src/libgit2/trailer.c",
        "src/libgit2/transaction.c",
        "src/libgit2/transport.c",
        "src/libgit2/tree.c",
        "src/libgit2/tree-cache.c",
        "src/libgit2/worktree.c",

        "src/libgit2/streams/mbedtls.c",
        "src/libgit2/streams/openssl.c",
        "src/libgit2/streams/openssl_dynamic.c",
        "src/libgit2/streams/openssl_legacy.c",
        "src/libgit2/streams/registry.c",
        "src/libgit2/streams/socket.c",
        "src/libgit2/streams/stransport.c",
        "src/libgit2/streams/tls.c",

        "src/libgit2/transports/auth.c",
        "src/libgit2/transports/auth_negotiate.c",
//        "src/libgit2/transports/auth_ntlm.c",
        "src/libgit2/transports/credential.c",
        "src/libgit2/transports/credential_helpers.c",
        "src/libgit2/transports/git.c",
        "src/libgit2/transports/http.c",
        "src/libgit2/transports/httpclient.c",
        "src/libgit2/transports/local.c",
        "src/libgit2/transports/smart.c",
        "src/libgit2/transports/smart_pkt.c",
        "src/libgit2/transports/smart_protocol.c",
        "src/libgit2/transports/ssh.c",
        "src/libgit2/transports/winhttp.c",

        "src/libgit2/xdiff/xdiffi.c",
        "src/libgit2/xdiff/xemit.c",
        "src/libgit2/xdiff/xhistogram.c",
        "src/libgit2/xdiff/xmerge.c",
        "src/libgit2/xdiff/xpatience.c",
        "src/libgit2/xdiff/xprepare.c",
        "src/libgit2/xdiff/xutils.c",

        "src/util/alloc.c",
        "src/util/date.c",
        "src/util/filebuf.c",
        "src/util/fs_path.c",
        "src/util/futils.c",
        "src/util/hash.c",
        "src/util/net.c",
        "src/util/pool.c",
        "src/util/posix.c",
        "src/util/pqueue.c",
        "src/util/rand.c",
        "src/util/regexp.c",
        "src/util/runtime.c",
        "src/util/sortedcache.c",
        "src/util/str.c",
        "src/util/strmap.c",
        "src/util/thread.c",
        "src/util/tsort.c",
        "src/util/utf8.c",
        "src/util/util.c",
        "src/util/varint.c",
        "src/util/vector.c",
        "src/util/wildmatch.c",
        "src/util/zstream.c",

        "src/util/allocators/failalloc.c",
        "src/util/allocators/stdalloc.c",

        "src/util/hash/openssl.c",

        "src/util/unix/map.c",
        "src/util/unix/realpath.c",
//        "src/util/hash/builtin.c",
 //       "src/util/hash/collisiondetect.c",
 //       "src/util/hash/common_crypto.c",
//        "src/util/hash/mbedtls.c",
 //       "src/util/hash/rfc6234/sha224-256.c",
  //      "src/util/hash/sha1dc/sha1.c",
  //      "src/util/hash/sha1dc/ubc_check.c",
    }, &.{
        "-Wall",
        "-W",
        "-Wstrict-prototypes",
        "-Wwrite-strings",
        "-Wno-missing-field-initializers",
    });
    libgitz.install();
    libgitz.installHeadersDirectory("include", "gitz");

    // to ensure linking works
    const examples = b.addExecutable(.{
        .name = "clone",
        .target = target,
        .optimize = optimize
    });
    examples.addCSourceFiles(&.{
        "examples/add.c",
        "examples/args.c",
        "examples/blame.c",
        "examples/cat-file.c",
        "examples/checkout.c",
        "examples/clone.c",
        "examples/commit.c",
        "examples/common.c",
        "examples/config.c",
        "examples/describe.c",
        "examples/diff.c",
        "examples/fetch.c",
        "examples/for-each-ref.c",
        "examples/general.c",
        "examples/index-pack.c",
        "examples/init.c",
        "examples/lg2.c",
        "examples/log.c",
        "examples/ls-files.c",
        "examples/ls-remote.c",
        "examples/merge.c",
        "examples/push.c",
        "examples/remote.c",
        "examples/rev-list.c",
        "examples/rev-parse.c",
        "examples/show-index.c",
        "examples/stash.c",
        "examples/status.c",
        "examples/tag.c",
    }, &.{
        "-Wall",
        "-W",
        "-Wstrict-prototypes",
        "-Wwrite-strings",
        "-Wno-missing-field-initializers",
    });
    examples.addIncludePath("./include");
    examples.linkLibC();
    examples.linkLibrary(libgitz);
    examples.linkSystemLibrary("openssl");
    examples.install();
}
