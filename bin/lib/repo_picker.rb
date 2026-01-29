#!/usr/bin/ruby --disable-gems

require 'io/console'

class RepoPicker
  FIELD_SEP = "\u2007"
  SRC_DIR = "#{ENV['HOME']}/src"
  Aborted = Class.new(StandardError)

  PREVIEW_PROGRAM = <<~PREVIEW
    echo "\e[96;4m"{2}"\e[0m \\c";
    timeout 0.3 #{File.join(ENV['HOME'], 'bin/git-line')} {1} 2> /dev/null || echo "";
    DIR={1}
    echo "\e[90m${DIR###{SRC_DIR}/}\e[0m";
    echo "";
    /opt/homebrew/bin/bat --color=always {1}/README.md --file-name README.md 2> /dev/null || cat {1}/README.md 2> /dev/null || ls --color=always {1}
  PREVIEW


  def refresh_dirs
    git_dirs(no_cache: true)
  end

  def interactive_pick
    max_len = fields.map { |_, repo, _| repo.length }.max
    preview_width = IO.console.winsize[1] - max_len - 7
    padding = ' ' * max_len

    io = IO.popen([
      '/opt/homebrew/bin/fzf',
      '-d', FIELD_SEP,
      '--nth', '2..',
      '--with-nth', '2..',
      '--preview', PREVIEW_PROGRAM,
      '--no-hscroll',
      '--ellipsis', '',
      '--preview-window', "right,#{preview_width},~3",
    ], 'r+')

    # Fields: dir, name, additional search terms
    fields.each do |dir, repo, url|
      IO.popen([File.join(ENV['HOME'], 'bin/git-line'), dir], 'r+') # Warm up the git fsmonitor cache. We intentionally don't wait for this to finish - it's best effort.
      io.write("#{dir}#{FIELD_SEP}#{repo}#{FIELD_SEP}#{padding}#{url}\n")
    end
    io.write("#{ENV['HOME']}#{FIELD_SEP}~#{FIELD_SEP}#{padding}`~#{ENV['HOME']}home\n")
    io.close_write
    dir, name, _ = io.read.chomp.split(FIELD_SEP)
    Process.wait(io.pid)
    stat = $?
    raise Aborted unless stat.success?
    [dir, name]
  end

  private

  def git_dirs(no_cache: false)
    File.delete("#{SRC_DIR}/.git_dirs") if no_cache
    return File.read("#{SRC_DIR}/.git_dirs").split("\n")
  rescue Errno::ENOENT
    dirs = Dir.glob("#{SRC_DIR}/**/.git").map do |dir|
      File.dirname(dir)
    end
    dirs.reject! { |dir| dirs.any? { |d| dir.start_with?(d + '/') } } # Skip subdirectories of other directories (git submodules)
    File.write("#{SRC_DIR}/.git_dirs", dirs.join("\n"))
    dirs
  end

  def fields
    @fields ||= (git_dirs.map do |dir|
      url = dir.delete_prefix(SRC_DIR)
      repo = File.basename(url)
      [dir, repo, url]
    end)
  end
end
