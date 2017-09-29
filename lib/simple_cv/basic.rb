require "simple_cv/layout"
require "hashugar"
require "json"
require "yaml"

module SimpleCV
  class Basic
    attr_reader :config

    def initialize config_path:
      @config = build_struct_tree parse_config_file config_path
    end

    # Render file
    #
    # With given path and filename, pdf can be rendered to a specific
    # location. If no arguments are given, filename will be set to
    # SimpleCV.pdf and pdf will be rendered to current working dir.

    def render_file filename: "SimpleCV", path: nil
      output_path = File.join(path || Dir.pwd, "#{filename.chomp('.pdf')}.pdf")
      Layout.new(config: @config).render_file(output_path)
      output_path
    end

    private

    # Parse config
    #
    # Currently yml and json files are supported. Will parse file content to hash.

    def parse_config_file config_path
      File.open(config_path, "r") do |file|
        case File.extname(file).delete(".")
        when "json" then JSON.parse(file.read)
        when "yml" then YAML.load_file(file)
        else
          file.close
          raise LoadError, "Type of file is not supported."
        end
      end
    end

    # Struct tree
    #
    # Since i prefere to use dot notation to navigate through medium size hashes,
    # parse hash into open structs

    def build_struct_tree data
      data.to_hashugar
    end

  end
end
