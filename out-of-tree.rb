require "language/go"

class OutOfTree < Formula
  desc "out-of-tree kernel {module, exploit} development tool"
  homepage "out-of-tree.io"
  url "https://code.dumpstack.io/tools/out-of-tree.git", :tag => "v2.1.0"

  depends_on "go" => :build

  depends_on "qemu"
  depends_on "podman"
  depends_on "jq"

  def install
    ENV["GOPATH"] = buildpath

    bin_path = buildpath/"src/code.dumpstack.io/tools/out-of-tree"
    bin_path.install Dir["*"]

    Language::Go.stage_deps resources, buildpath/"src"
    cd bin_path do
      system "go", "build", "-o", bin/"out-of-tree", "."
    end
  end
end
