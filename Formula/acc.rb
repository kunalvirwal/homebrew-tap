class Acc < Formula
  desc "Compose CLI for Apple Containers"
  homepage "https://github.com/kunalvirwal/apple-container-compose"

  url "https://github.com/kunalvirwal/apple-container-compose/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "5c3526dfafd9fc212b8aeb9fde9867ad45ed8bdad7531c81a0d46d88460d71b9"
  license "Apache-2.0"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  depends_on "go" => :build

  def fetch
    system "go", "mod", "download"
  end

  def install
    ENV["GOPROXY"] = "off"

    system "go", "build",
           "-mod=readonly",
           *std_go_args(output: bin/"acc"),
           "./cmd/acc"
  end

  def caveats
    <<~EOS
      ACC requires Apple's container CLI, installed separately:
        https://github.com/apple/container#get-started

      Start the runtime before using ACC:
        container system start
    EOS
  end

  test do
    assert_match "__start_acc",
                 shell_output("#{bin}/acc completion bash")
  end
end