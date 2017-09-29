require "prawn"
require "prawn-svg"

module SimpleCV
  class Layout < ::Prawn::Document

    def initialize config:
      @config = config

      super({
        page_size: "A4",
        info: {
          Title: @config.title,
          Author: @config.author,
          Creator: "AwesomeCV",
          Producer: "AwesomeCV",
          CreationDate: Time.now
        }
      })

      font_families.update "Default" => default_font_files
      font "Default"
      stroke_color "000000"
      main
    end

    # Main
    #
    # This builds main layout. Document is diveded in two columns.
    # First column provides personal details and skills, second
    # column show historic experience and education.

    def main
      bounding_box([0, 770], width: 170) do
        job
        profile
        contact
        skills
      end

      bounding_box([200, 770], width: 320) do
        experience
        education
      end
    end

    def job
      h1 @config.profile&.name
      text @config.profile&.job, style: :normal, size: 11
      stroke
      move_down 25
    end

    def profile
      h2 "profile"
      text @config.profile&.description, style: :normal, size: 10
      move_down 25
    end

    def contact
      h2 "contact"
      contact_table
      move_down 25
    end

    def skills
      h2 "skills"
      skill_table
      move_down 25
    end

    def experience
      h2 "experience"
      @config.experience&.each do |elem|
        h3 elem.job
        h4 "#{elem.company} - #{elem.location}"
        h4 elem.date
        move_down 5
        paragaph elem.description
        move_down 14
      end
    end

    def education
      h2 "education"
      @config.education&.each do |elem|
        h3 elem.subject
        h4 elem.institution
        h4 elem.date
        move_down 14
      end
    end

    private

    # Set fonts
    #
    # Font of document can be customized over config file.
    # TODO: check if file exists, when path given over config file and do proper
    # error handling

    def default_font_files
      {
        light: @config.font&.light || File.join("lib", "font", "Lato-Light.ttf"),
        normal: @config.font&.normal || File.join("lib", "font", "Lato-Medium.ttf"),
        bold: @config.font&.bold || File.join("lib", "font", "Lato-Bold.ttf")
      }
    end

    def h1 title
      text title&.upcase, style: :bold, size: 22, leading: 5
      line_width(0.5)
      stroke_color "000000"
      horizontal_rule
      move_down 10
    end

    def h2 title
      text title&.upcase, style: :normal, size: 12, leading: 5
      line_width(2)
      stroke_color "000000"
      horizontal_rule
      move_down 15
      stroke
    end

    def h3 title
      text title, style: :bold, size: 11
    end

    def h4 title
      text title, style: :normal, size: 9
    end

    def paragaph text
      text text, style: :normal, size: 9, color: "515151"
    end

    def contact_table
      line_width(1)
      stroke_color "c6c6c6"

      @config.contact&.each_with_index do |elem, index|
        icon, value = elem

        path = path = File.join(File.expand_path(File.dirname(__FILE__)), "..", "icons", "#{icon}.svg")
        if File.exist?(path)
          File.open(path, "r") do |icon|
            svg icon.read, svg_fit(icon.read, 10, 10)
          end

          line 20, cursor+10, 20, cursor
          stroke

          move_up 10
        end

        text value, style: :normal, size: 9, align: :right, width: 170, leading: 9

        if index+1 < @config.contact.count
          horizontal_line 0, 170, at: cursor+5
          stroke
        end
      end
    end

    def skill_table
      move_down 5
      line_width(3)

      @config.skills&.each do |skill, value|
        text skill || " ", size: 9, leading: 5

        if value
          stroke_color "c6c6c6"
          horizontal_line 110, 170, at: cursor+11
          stroke

          stroke_color "000000"
          horizontal_line 110, 110+(60*value/100), at: cursor+11
          stroke
        end
      end
    end

    # Shrink svg images
    #
    # Helper method to resize given svg images to a specific width and height range.

    def svg_fit file, width, height
      viewBox = file[/(viewBox=)[\-\".0-9 ]*/]
      return { height: height } unless viewBox

      metric = viewBox.tr("viewBox=", "").tr("\"", "").split(" ")
      scale = metric.third.to_i / metric.fourth.to_i

      if (scale * height) > width
        { width: width }
      else
        { height: height }
      end
    end

  end
end
