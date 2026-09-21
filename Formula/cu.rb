class Cu < Formula
  desc "Token-aware computer-use runtime for macOS agents"
  homepage "https://github.com/Arnavxy/cu"
  url "https://github.com/Arnavxy/cu/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "69262aa8a5c1a236bff1b924e5f66d6c4b0dd4cdd35a41118248e78b231e7892"
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
    assert_equal "cu 0.2.1", shell_output("#{bin}/cu --version").strip

    (testpath/"pixel.svg").write <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="2" height="2">
        <rect width="2" height="2" fill="#3366ff"/>
      </svg>
    SVG
    assert_match(/\A[0-9a-f]{16}\z/, shell_output("#{bin}/cu-native fingerprint #{testpath}/pixel.svg").strip)
  end
end
