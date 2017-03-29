# frozen_string_literal: true

# Apply license, provided by ``version_info`` on project files
#
# Samples of use:
#
# ~~~~
# Project::Licenser.process do |process|
#    process.license  = Project.version_info[:license]
#    process.patterns = ['src/bin/*', 'src/**/**.rb']
# end.apply
# ~~~~
#
# ~~~~
# Project::Licenser.process do |process|
#     process.files += Dir.glob('src/bin/*')
# end
# ~~~~
class Project::Licenser
  attr_accessor :license
  attr_accessor :files
  attr_reader   :patterns

  class << self
    def process(&block)
      self.new.process(&block)
    end
  end

  def initialize
    @patterns = []
    @files = Project.spec.files.reject { |f| !f.scan(/\.rb$/)[0] }
    @license ||= Project.version_info[:license]

    yield self if block_given?
  end

  # @param [Array<String>]
  def patterns=(patterns)
    @files ||= []
    patterns.each { |pattern| @files += Dir.glob(pattern) }
    @patterns = patterns
  end

  # @return [Array<Pathname>]
  def files
    @files.each.map { |file| Pathname.new(file) }.sort
  end

  # Get license, formatted (using comments)
  #
  # @return [String]
  def license
    @license.to_s.gsub(/\n{3}/mi, "\n\n").lines.map do |line|
      line.chomp!

      line = "# #{line}" if line and line[0] != '#'
    end.join("\n")
  end

  # @return [Regexp]
  def license_regexp
    /#{Regexp.quote(license)}/mi
  end

  # Apply license on processable files
  #
  # @return [self]
  def process
    yield self if block_given?

    files.each { |file| apply_license(file, license) }

    self
  end

  protected

  # Get an index, skipping comments
  #
  # @param [Array<String>]
  # @return [Fixnum]
  def index_lines(lines)
    index = 0
    loop do
      break unless lines[index] and lines[index][0] == '#'

      index += 1
    end

    index
  end

  # Apply license on a file
  #
  # @param [Pathname] file
  # @param [String] license
  def apply_license(file, license)
    license    = license.to_s
    regexp     = license_regexp
    content    = file.read
    licensable = !content.scan(regexp)[0] and !license.empty?

    if licensable
      content = make_lines(content.lines).join('') if licensable
      file.write(content)
    end

    file
  end

  def make_lines(lines)
    index = index_lines(lines)
    lines = lines.clone

    return lines if index <= 0

    lines[0..index] + license.lines + ["\n"] + lines[index..-1]
  end
end
