require "language/go"

class Docker < Requirement
  fatal true

  satisfy(:build_env => false) { which("docker") }

  def message; <<~EOS
    docker is required; install it via:
      brew cask install docker

    Note that you should start docker and wait for initialization before the docker command will appear.

    EOS
  end
end

class OutOfTree < Formula
  desc "out-of-tree kernel {module, exploit} development tool"
  homepage "out-of-tree.io"
  url "https://code.dumpstack.io/tools/out-of-tree.git", :tag => "v2.0.3"

  depends_on "go" => :build

  depends_on "qemu"
  depends_on Docker

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
