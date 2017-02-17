class GitScripts < Formula
  desc "Scripts I've either written, downloaded or clipped from #git."
  homepage "https://github.com/jwiegley/git-scripts"
  url "https://github.com/jwiegley/git-scripts.git",
    :revision => "772286aa825b11d572dbe4052c9057c9b40f778d"
  version "1.0.0"
  revision 3
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

    scripts = %w[
      git-addremove
      git-addsub
      git-addtree
      git-all-commits
      git-all.rb
      git-amend-all
      git-apply-url
      git-archive-all
      git-branch-status-subtree/git-branch-status
      git-build
      git-changebar
      git-changelog
      git-checkout-branches
      git-children-of
      git-clone.sh
      git-closest-match
      git-cmpdir
      git-contr
      git-current
      git-delete-branch
      git-delete-tag
      git-diff-directory
      git-diff-dw
      git-dired.el
      git-discover-large-blobs
      git-empty-branch
      git-erase-reflog
      git-every
      git-external-ediff
      git-filemerge
      git-find
      git-find-blob
      git-find-children
      git-find-fetch
      git-find-usefull-dangling-trees
      git-fire-subtree/git-fire
      git-fixws
      git-flatten.rb
      git-flush
      git-follow
      git-force-mtimes
      git-forest
      git-full-reset
      git-hunt-and-seek
      git-ignore-wizard
      git-igunk
      git-interactive-merge
      git-master
      git-maxpack
      git-merge-dw
      git-merge-from-svn
      git-merge-repo
      git-opendiff
      git-pr
      git-publish
      git-publish-repo
      git-pulltree
      git-push-all
      git-push-branch
      git-push-home
      git-rank-contributors
      git-rebranch
      git-record
      git-remote-in-sync.sh
      git-remove
      git-remove-empty-commits
      git-rename
      git-retrack
      git-rm-conflicts
      git-root
      git-save
      git-save-file
      git-save-home
      git-signed-tag
      git-smerge
      git-snapshot
      git-standup
      git-status-all
      git-svn-diff
      git-sync
      git-tag-diff
      git-tarball
      git-touch-repos
      git-track-branch
      git-trash
      git-trial-merge
      git-undo
      git-unpack
      git-whoami
      git-working-tree
      git-write-stream-info
      git-wtf
    ]

    bin.env_script_all_files(scripts, :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    system "#{bin}/git-wtf", "--help"
  end
end
