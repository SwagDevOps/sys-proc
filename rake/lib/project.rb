# frozen_string_literal: true

class Project
  class << self
    # @return [Symbol]
    def name
      require 'dotenv/load'

      ENV.fetch('PROJECT_NAME').to_sym
    end

    # Main class (subject of project)
    #
    # @return [Class]
    def subject
      require '%s/src/lib/%s' % [Dir.pwd, Project.name]

      name = self.name.to_s.gsub('-', '/')
      inflector.constantize(inflector.classify(name))
    end

    # Gem specification
    #
    # @return [Gem::Specification]
    def spec
      Gem::Specification::load('%s/%s.gemspec' % [Dir.pwd, name])
    end

    # @return [Hash]
    def version_info
      ({version: subject.VERSION.to_s}.merge(subject.version_info)).freeze
    end

    # Gem (packaged)
    #
    # @return [Pathname]
    def gem
      Pathname.new('pkg').join("#{spec.name}-#{spec.version}.gem")
    end

    protected

    # @return [ActiveSupport::Inflector]
    def inflector
      require 'active_support/inflector'

      ActiveSupport::Inflector
    end
  end
end
