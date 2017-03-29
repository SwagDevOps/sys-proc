# frozen_string_literal: true

file "#{Project.name}.gemspec" => \
     FileList.new("src/#{Project.name}.gemspec.tpl",
                  'Gemfile',
                  'src/**/*.rb',
                  'src/**/version_info.yml') do
  [:ostruct, :pathname, :gemspec_deps_gen, :tenjin].each do |required|
    require required.to_s
  end

  tools = OpenStruct.new(
    deps_gen: GemspecDepsGen.new,
    template: Tenjin::Engine.new(cache: false),
  )

  files = OpenStruct.new(
    templated: Pathname.new("src/#{Project.name}.gemspec.tpl"),
    generated: Pathname.new(Dir.pwd).join("#{Project.name}.gemspec"),
  )

  spec_id = files.templated
              .read
              .scan(/Gem::Specification\.new\s+do\s+\|([a-z]+)\|/)
              .flatten.fetch(0)

  context = {
    dependencies: tools.deps_gen.generate_project_dependencies(spec_id).strip,
    name: Project.name,
  }.merge(Project.version_info)

  content = tools.template.render(files.templated.to_s, context)
  files.generated.write(content)
end
