class Indri < Formula
  desc "search engine that provides state-of-the-art text search and a rich structured query language for text collections of up to 50 million documents"
  homepage "http://lemurproject.org/indri.php"
  url "http://downloads.sourceforge.net/project/lemur/lemur/indri-5.11/indri-5.11.tar.gz"
  version "5.11"
  sha256 "e9a1dcd02e2dc12742f8b257ae8ea341f19c4fcf931c84d95f655fe57885ac85"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "sh", "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test indri`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    File.open("test_parameters.xml", "r+") do |file|
      "<parameter><corpus><path></path></corpus></parameter>"
    end

    system "#{bin}/IndriBuildIndex", "test_parameters.xml"
  end
end
