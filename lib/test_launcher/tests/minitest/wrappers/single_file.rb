require "test_launcher/utils/path"

module TestLauncher
  module Tests
    module Minitest
      module Wrappers
        class SingleFile < Struct.new(:file)

          def to_command
            %{cd #{File.join(app_root)} && #{run_command} #{File.join(relative_test_path)}}
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
