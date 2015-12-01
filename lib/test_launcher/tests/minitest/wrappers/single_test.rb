require "test_launcher/utils/path"

module TestLauncher
  module Tests
    module Minitest
      module Wrappers
        class SingleTest

          attr_reader :file, :name
          private :file, :name

          def initialize(file:, line:)
            @file = file
            @name = line[/\s*def\s+(.*)/, 1]
          end

          def to_command
            %{cd #{app_root} && #{run_command} #{relative_test_path} --name=/#{name}/}
          end

          def app_root
            exploded_path = Utils::Path.split(file)

            path = exploded_path[0...exploded_path.rindex("test")]
            File.join(path)
          end

          def relative_test_path
            exploded_path = Utils::Path.split(file)
            path = exploded_path[exploded_path.rindex("test")..-1]
            File.join(path)
          end

          private

          def run_command
            if File.exist?(File.join(app_root, 'bin/testunit'))
              'bin/testunit'
            elsif File.exist?(File.join(app_root, 'bin/spring'))
              'bin/spring testunit'
            else
              'ruby -I test'
            end
          end
        end
      end
    end
  end
end
