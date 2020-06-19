# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler32-1.0.4
aho-corasick-0.7.8
ansi_term-0.11.0
anyhow-1.0.26
assert-json-diff-1.0.3
atty-0.2.14
autocfg-0.1.7
autocfg-1.0.0
backtrace-0.3.44
backtrace-sys-0.1.32
base64-0.10.1
bitflags-1.2.1
bstr-0.2.11
bumpalo-3.2.0
byteorder-1.3.4
bytes-0.4.12
c2-chacha-0.2.3
cc-1.0.50
cfg-if-0.1.10
chrono-0.4.10
clap-2.33.0
cloudabi-0.0.3
colored-1.9.3
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.6.4
core-foundation-sys-0.6.2
crc32fast-1.2.0
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.1
crossbeam-utils-0.7.2
csv-1.1.3
csv-core-0.1.10
ct-logs-0.6.0
difference-2.0.0
dtoa-0.4.5
either-1.5.3
encoding_rs-0.8.22
env_logger-0.7.1
error-chain-0.12.2
extend-0.1.1
failure-0.1.6
failure_derive-0.1.6
flate2-1.0.13
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.29
futures-cpupool-0.1.8
getrandom-0.1.14
h2-0.1.26
heck-0.3.1
hermit-abi-0.1.8
http-0.1.21
http-body-0.1.0
httparse-1.3.4
humantime-1.3.0
hyper-0.12.35
hyper-rustls-0.17.1
hyper-tls-0.3.2
idna-0.1.5
idna-0.2.0
indexmap-1.3.2
iovec-0.1.4
itoa-0.4.5
js-sys-0.3.35
kernel32-sys-0.2.2
lazy_static-1.4.0
libc-0.2.67
lock_api-0.3.3
log-0.4.8
matches-0.1.8
maybe-uninit-2.0.0
md5-0.7.0
memchr-2.3.3
memoffset-0.5.3
mime-0.3.16
mime_guess-2.0.1
miniz_oxide-0.3.6
mio-0.6.21
miow-0.2.1
mockito-0.23.3
native-tls-0.2.3
net2-0.2.33
nom-4.2.3
num-integer-0.1.42
num-traits-0.2.11
num_cpus-1.12.0
openssl-0.10.28
openssl-probe-0.1.2
openssl-sys-0.9.54
parking_lot-0.9.0
parking_lot_core-0.6.2
percent-encoding-1.0.1
percent-encoding-2.1.0
pkg-config-0.3.17
ppv-lite86-0.2.6
proc-macro-error-0.4.9
proc-macro-error-attr-0.4.9
proc-macro2-1.0.9
publicsuffix-1.5.4
quick-error-1.2.3
quote-1.0.2
rand-0.6.5
rand-0.7.3
rand_chacha-0.1.1
rand_chacha-0.2.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.56
regex-1.3.4
regex-automata-0.1.8
regex-syntax-0.6.14
remove_dir_all-0.5.2
reqwest-0.9.24
ring-0.16.11
rustc-demangle-0.1.16
rustc_version-0.2.3
rustls-0.16.0
rustversion-1.0.2
ryu-1.0.2
schannel-0.1.17
scopeguard-1.1.0
sct-0.6.0
security-framework-0.3.4
security-framework-sys-0.3.3
semver-0.9.0
semver-parser-0.7.0
serde-1.0.104
serde_derive-1.0.104
serde_json-1.0.48
serde_urlencoded-0.5.5
slab-0.4.2
smallvec-0.6.13
smallvec-1.2.0
sourcefile-0.1.4
spin-0.5.2
string-0.2.1
strsim-0.8.0
syn-1.0.16
syn-mid-0.5.0
synstructure-0.12.3
tempfile-3.1.0
termcolor-1.1.0
textwrap-0.11.0
thread_local-1.0.1
time-0.1.42
tokio-0.1.22
tokio-buf-0.1.1
tokio-current-thread-0.1.7
tokio-executor-0.1.10
tokio-io-0.1.13
tokio-reactor-0.1.12
tokio-rustls-0.10.3
tokio-sync-0.1.8
tokio-tcp-0.1.4
tokio-threadpool-0.1.18
tokio-timer-0.2.13
try-lock-0.2.2
try_from-0.3.2
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.12
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
untrusted-0.7.0
url-1.7.2
url-2.1.1
uuid-0.7.4
vcpkg-0.2.8
vec_map-0.8.1
version_check-0.1.5
version_check-0.9.1
want-0.2.0
wasi-0.9.0+wasi-snapshot-preview1
wasm-bindgen-0.2.58
wasm-bindgen-backend-0.2.58
wasm-bindgen-macro-0.2.58
wasm-bindgen-macro-support-0.2.58
wasm-bindgen-shared-0.2.58
wasm-bindgen-webidl-0.2.58
web-sys-0.3.35
webpki-0.21.2
webpki-roots-0.17.0
weedle-0.10.0
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.3
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
xml-rs-0.8.0"

inherit cargo

DESCRIPTION="Speedtest.net testing utility in Rust"
HOMEPAGE="https://github.com/nelsonjchen/speedtest-rs"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"

DEPEND="
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"
