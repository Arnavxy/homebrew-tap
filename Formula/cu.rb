class Cu < Formula
  desc "Token-aware computer-use runtime for macOS agents"
  homepage "https://github.com/Arnavxy/cu"
  url "https://github.com/Arnavxy/cu/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b5943b05e511b2907c9092011d9aa14ee5472a79b123389fbb03f990dbbda1b2"
  license "MIT"

  depends_on "cliclick"
  depends_on macos: :ventura

  def install
    system "xcrun", "swiftc", "-O",
           "-framework", "AppKit",
           "-framework", "CoreGraphics",
           "-framework", "Vision",
           "Sources/cu-native/main.swift",
           "-o", "cu-native"

    bin.install "bin/cu"
    bin.install "cu-native"
  end

  test do
    assert_equal "cu 0.2.0", shell_output("#{bin}/cu --version").strip
    assert_match "observe", shell_output("#{bin}/cu help")
  end
end
