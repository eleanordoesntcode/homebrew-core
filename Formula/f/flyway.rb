class Flyway < Formula
  desc "Database version control to control migrations"
  homepage "https://flywaydb.org/"
  url "https://github.com/flyway/flyway/releases/download/flyway-11.10.2/flyway-commandline-11.10.2.tar.gz"
  sha256 "d51fc28303d5dbaeaf0b8f8b3bc1d964d36b7d60d98d79b51eda557200c3c410"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "b1f1d5efdc6f0e724f8fec9021585313d6a9f444318c37355372e90f91b719ab"
  end

  depends_on "openjdk"

  def install
    rm Dir["*.cmd"]
    chmod "g+x", "flyway"
    libexec.install Dir["*"]
    (bin/"flyway").write_env_script libexec/"flyway", Language::Java.overridable_java_home_env
  end

  test do
    system bin/"flyway", "-url=jdbc:h2:mem:flywaydb", "validate"
  end
end
