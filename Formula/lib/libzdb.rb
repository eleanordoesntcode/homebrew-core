class Libzdb < Formula
  desc "Database connection pool library"
  homepage "https://tildeslash.com/libzdb/"
  url "https://tildeslash.com/libzdb/dist/libzdb-3.4.0.tar.gz"
  sha256 "abd675719bcbdde430aa4ee13975b980d55d2abcb5cc228082a30320a6bb9f0f"
  license "GPL-3.0-only"

  livecheck do
    url :homepage
    regex(%r{href=.*?dist/libzdb[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "c97a8bf09b5b6149e9b00055c7a41bdc44d30d24dba89057d10c692c66775ac8"
    sha256 cellar: :any,                 arm64_sonoma:  "0b8ddfd01835494761c61f79bbf0268ed9970eda906751f394345132ee8f1e99"
    sha256 cellar: :any,                 arm64_ventura: "2a68a90b4ae8eaf45dce9319688be51e9cbbed3f8906492641b04d7b03db03b2"
    sha256 cellar: :any,                 sonoma:        "a60352d7b1e4544558bb754abfa0d792f4b30dec3ef8e3d36243885fde8005c2"
    sha256 cellar: :any,                 ventura:       "a1d91f504e85283dade237952dd3872e28d253065de94e63ee3dd1b1509dfab6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eac6ae172d51fd94fc04a71798011d683d07d46f0e52b5de22968289e74fd01a"
  end

  depends_on "gcc"
  depends_on "libpq"
  depends_on macos: :high_sierra # C++ 17 is required
  depends_on "mysql-client"
  depends_on "sqlite"

  def install
    # Reduce linkage on macOS from `mysql-client`
    ENV.append "LDFLAGS", "-Wl,-dead_strip_dylibs" if OS.mac?
    ENV["CC"] = "gcc-14"
    ENV["CXX"] = "g++-14"
    ENV.append_to_cflags "-I/opt/homebrew/include"
    system "./configure", "--disable-silent-rules", "--enable-sqliteunlock", *std_configure_args
    system "make", "install"
    (pkgshare/"test").install Dir["test/*.{c,cpp}"]
  end

  test do
    cp_r pkgshare/"test", testpath
    cd "test" do
      system ENV.cc, "select.c", "-L#{lib}", "-lpthread", "-lzdb", "-I#{include}/zdb", "-o", "select"
      system "./select"
    end
  end
end
