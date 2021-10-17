class Dub < Formula
  desc "Build tool for D projects"
  homepage "https://code.dlang.org/getting_started"
  url "https://github.com/dlang/dub/archive/v1.27.0.tar.gz"
  sha256 "fb800f3355f167ac7f997f77e31e331db9d33477779fdaaf2851b3abcecc801a"
  license "MIT"
  version_scheme 1
  head "https://github.com/dlang/dub.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "32e9dce2c1cc47a1cf87aade977540626be52aba5e3ac1201a74ddce9775c9bb"
    sha256 cellar: :any_skip_relocation, big_sur:       "a10d0c59b8cbf93854cc3971fa08d9733b03ebfbaf155d2562577614b05bf4b3"
    sha256 cellar: :any_skip_relocation, catalina:      "04ce7954514cb942fdca86f3fb665202266ae6e9772fa313cfcc2247641a0f6c"
    sha256 cellar: :any_skip_relocation, mojave:        "ee99a2ad1701af3348ecbe2fc6f88fe8e314d89abb43b575cb9d312365a9cc25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4df84c7a2eaafa40eaecd84b7f761bf6536111639ba2a0212eb3c6af97abc4af"
  end

  depends_on "ldc" => :build
  depends_on "pkg-config"

  uses_from_macos "curl"

  def install
    ENV["GITVER"] = version.to_s
    system "ldc2", "-run", "./build.d"
    system "bin/dub", "scripts/man/gen_man.d"
    bin.install "bin/dub"
    man1.install Dir["scripts/man/*.1"]
    zsh_completion.install "scripts/zsh-completion/_dub"
    fish_completion.install "scripts/fish-completion/dub.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dub --version").split(/[ ,]/)[2]
  end
end
