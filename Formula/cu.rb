class Cu < Formula
  desc "Token-aware native macOS computer-use runtime for agents"
  homepage "https://github.com/Arnavxy/cu"
  license "MIT"
  version "0.5.0"

  on_macos do
    on_arm do
      url "https://github.com/Arnavxy/cu/releases/download/v0.5.0/cu-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "8650bf446ab96fd5cb7cea23461115f99fb678363d2a7b9f1c2a62582168c78f"
    end
    on_intel do
      url "https://github.com/Arnavxy/cu/releases/download/v0.5.0/cu-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "d3e2d46fed06a945543c2599e3cc3b8def30bc9141bdcd78e1738b0a265dad0c"
    end
  end

  depends_on macos: :ventura

  def install
    bin.install "bin/cu", "bin/cu-native", "bin/cu-input", "bin/cu-mcp"
    doc.install "docs"
  end

  test do
    assert_equal "cu 0.5.0", shell_output("#{bin}/cu --version").strip
    assert_match "0.5.0", shell_output("#{bin}/cu-input -V")
    request = %({"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}\n)
    response = JSON.parse(pipe_output("#{bin}/cu-mcp", request))
    assert_equal "0.5.0", response.fetch("result").fetch("serverInfo").fetch("version")

    (testpath/"pixel.svg").write <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="2" height="2">
        <rect width="2" height="2" fill="#3366ff"/>
      </svg>
    SVG
    assert_match(/\A[0-9a-f]{16}\z/, shell_output("#{bin}/cu-native fingerprint #{testpath}/pixel.svg").strip)
  end
end
