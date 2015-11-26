require "test_launcher/version"
require "test_launcher/shell/runner"
require "test_launcher/searchers/git_searcher"
require "test_launcher/tests/minitest/finder"
require "test_launcher/tests/minitest/consolidator"

module TestLauncher

  def self.find(input, run_all: false)
    shell = Shell::Runner.new(
      log_path: '/tmp/test_launcher.log',
      working_directory: '.',
    )

    searcher = Searchers::GitSearcher.new(shell)
    finder = Tests::FinderFactory.finder
    search_results = finder.find(input, searcher)
    test_wrapper = Tests::Minitest::Consolidator.consolidate(search_results, shell, run_all)

    shell.exec(test_wrapper.to_command)
  end
end
