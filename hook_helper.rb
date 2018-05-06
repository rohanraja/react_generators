require 'tempfile'
require 'fileutils'

class HooksHelper
  def addLineAfterHook(filePath, hookName, lineToAdd)
    input_file = filePath
    temp_file = Tempfile.new("#{hookName}.temp")
    begin
      File.open(input_file, 'r') do |file|
        file.each_line do |line|
          if line.include? hook_str(hookName)
            commentIdx = line.index('/')
            indentPart = line[0,commentIdx]
            temp_file.puts "#{indentPart}#{lineToAdd}"
          end
          temp_file.print line
        end
      end
      # temp_file.rewind
      # puts temp_file.read
      temp_file.close
      FileUtils.mv(temp_file.path, input_file)
    ensure
      temp_file.close!
    end

  end 

  def addFileAfterHook(filePath, hookName, fileToAdd)

    File.open(fileToAdd, 'r') do |file|
      file.each_line do |line|
        addLineAfterHook(filePath, hookName, line)
      end
    end
  end

private

  def hook_str(name)
    "-- #{name}_hook --"
  end
end

#
# h = HooksHelper.new
# fPath = "templates/store/rootReducer.js"
# name = "import"
# lineToAdd = "import {test} from './Test'"
#
# h.addLineAfterHook(fPath, name, lineToAdd)
#
# file = File.open(fPath, "r")
# puts file.read
