class Acc < Formula
  desc "Compose CLI for Apple Containers"
  homepage "https://github.com/kunalvirwal/apple-container-compose"

  url "https://github.com/kunalvirwal/apple-container-compose/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d347c21002a81d97f647cd4cde3aeb66c129c033e6e427a2686593a0ef1bf1fc"
  license "Apache-2.0"

  depends_on macos: :tahoe
  depends_on arch: :arm64
  depends_on "go" => :build
  depends_on "container"

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

  test do
    assert_match "__start_acc",
                 shell_output("#{bin}/acc completion bash")
  end
end