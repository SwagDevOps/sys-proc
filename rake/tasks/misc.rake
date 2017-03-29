# frozen_string_literal: true

require 'pathname'

if Pathname.new('.gitignore').exist?
  desc 'Reformat .gitignore file'
  task '.gitignore' do

    file = Pathname.new('.gitignore')
    content = file.read.lines
                  .sort_by { |m| m.downcase }
                  .map { |m| m.rstrip }
                  .reject(&:empty?)
                  .reject { |m| m[0] == '#' }
                  .join("\n")

    file.write(content)
  end
end
