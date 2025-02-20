class Jsrepo < Formula
  desc "Build and distribute your code"
  homepage "https://jsrepo.dev/"
  url "https://registry.npmjs.org/jsrepo/-/jsrepo-1.39.1.tgz"
  sha256 "99e39f4ae231911f55323e59725892c2eda8fedd0c6aba998575122e1768827d"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "072a04431b7de541273b2601760bb0a1cf2548e785af07fb83dff4c7e5c25f1c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "072a04431b7de541273b2601760bb0a1cf2548e785af07fb83dff4c7e5c25f1c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "072a04431b7de541273b2601760bb0a1cf2548e785af07fb83dff4c7e5c25f1c"
    sha256 cellar: :any_skip_relocation, sonoma:        "b4b4fec4d7105ca51509d19ad7ba5a03b9ab3a18ab7aef9ccba4ad6249cb21bc"
    sha256 cellar: :any_skip_relocation, ventura:       "b4b4fec4d7105ca51509d19ad7ba5a03b9ab3a18ab7aef9ccba4ad6249cb21bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "072a04431b7de541273b2601760bb0a1cf2548e785af07fb83dff4c7e5c25f1c"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jsrepo --version")

    system bin/"jsrepo", "build"
    assert_match "\"categories\": []", (testpath/"jsrepo-manifest.json").read
  end
end
