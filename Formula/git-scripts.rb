class GitScripts < Formula
  desc "Scripts written, downloaded or clipped from #git."
  homepage "https://github.com/thatgerber/git-scripts"
  url "https://github.com/thatgerber/git-scripts.git",
    :tag => "1.0.0",
    :revision => "7e3a0edfaa970b74311c84c23aa8641f5c50acfd"
  head "https://github.com/jwiegley/git-scripts.git"

  bottle do
    cellar :any_skip_relocation
  end

  resource "Git.pm" do
    url "https://cpan.metacpan.org/authors/id/M/MS/MSOUTH/Git-0.41.tar.gz"
    mirror "http://search.cpan.org/CPAN/authors/id/M/MS/MSOUTH/Git-0.41.tar.gz"
    sha256 "9d4de21612253a1d3252ff7657d7e832dcf3cc2a748a8c84f73de618a3a38239"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    resources.each do |res|
      res.stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make", "install"
      end
    end

    bin.install("bin/*")
    bin.env_script_all_files("bin_perl", :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    system "#{bin}/git-wtf", "--help"
  end
end
