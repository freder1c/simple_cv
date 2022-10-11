# frozen_string_literal: true

require "prawn"

module SimpleCV
  class Layout < ::Prawn::Document
    attr_reader :config, :black, :dark_gray, :light_gray

    def initialize(config = {})
      @config = config

      @black = "000000"
      @dark_gray = "6c6c6c"
      @light_gray = "A2A2A2"

      super({
        page_size: "A4",
        info: {
          Title: config["title"],
          Author: config["author"],
          Creator: config["author"],
          Producer: config["author"],
          CreationDate: Time.now
        }
      })

      font_families.update "Default" => default_font_files
      font "Default"
      stroke_color "000000"
      main

      if page_count > 1
        options = { start_count_at: 1, at: [0, -10], size: 7, style: :light, color: light_gray, align: :right }
        number_pages("Page <page> of <total>", options)
      end
    end

    def main
      header
      if config["intro"]
        intro
        start_new_page
      end
      experience
      education
      certification
    end

    def header
      text(config.dig("profile", "name")&.upcase, size: 20, leading: 3, character_spacing: 1.9)
      move_down(2)
      text(config.dig("profile", "job")&.upcase, style: :light, size: 12, leading: 3, character_spacing: 1.9, color: dark_gray)
      move_down(10)
      stroke_color(black)
      line_width(1)
      line([0, cursor], [523, cursor])
      stroke

      line_pointer = 770
      text_box(config.dig("contact", "address"), size: 8, at: [240, line_pointer], align: :right, style: :light)

      fill_color(dark_gray)

      config["contact"]&.each do |k,v|
        line_pointer -= 10
        text_box("<color rgb='#{black}'>#{k.capitalize}:</color> #{v}", size: 8, at: [240, line_pointer], align: :right, inline_format: true, style: :light)
      end

      fill_color(black)
      move_down(20)
    end

    def intro
      text_box(DateTime.now.strftime("%d.%m.%Y"), at: [0, cursor], align: :right, size: 7)
      text(config.dig("intro", "receiver", "name")&.upcase, size: 7, color: black)
      text(config.dig("intro", "receiver", "position")&.upcase, size: 7, color: dark_gray)

      move_down(30)
      text(config.dig("intro", "text"), size: 9, color: dark_gray, style: :light)

      # move_down(20)
      # stroke_color(light_gray)
      # line_width(0.5)
      # line([0, cursor], [523, cursor])
      # stroke
      # move_down(30)
    end

    def experience
      h2("work experience")
      last_cursor = start_cursor = cursor

      config["experience"]&.each do |elem|
        bounding_box([0, last_cursor], width: 523) do
          bounding_box([15, 0], width: 165) do
            fill_color(light_gray)
            stroke_color("ffffff")
            text_box("•", at: [-19, cursor+2], size: 13, color: light_gray, mode: :fill_stroke)
            fill_color(black)
            text(elem["company"], size: 9, style: :light)
            text(elem["date"], size: 7.5, color: dark_gray, style: :light)
          end

          bounding_box([180, bounds.top], width: 353, background_color: light_gray) do
            text(elem["job"], size: 9, leading: 7)

            elem["description_list"]&.each do |item|
              text_box("•", at: [0, cursor], size: 8, color: dark_gray)
              indent(10) { text(item, size: 8, color: dark_gray, style: :light) }
            end

            move_down(10)
            last_cursor -= bounds.top
          end
        end
      end

      end_cursor = cursor
      stroke_color(light_gray)
      line_width(0.5)
      line([0, start_cursor + 5], [0, end_cursor + 10])
      stroke

      move_down(10)
      stroke_color(light_gray)
      line_width(0.5)
      line([0, cursor], [523, cursor])
      stroke
      move_down(20)
    end

    def education
      h2("education")
      start_cursor = cursor

      config["education"]&.each_with_index do |elem, index|
        bounding_box([12 + (index * 180), start_cursor], width: 180) do
          text(elem["subject"], size: 9)
          text(elem["institution"], size: 9, style: :light)
          text(elem["date"], size: 7.5, color: dark_gray, style: :light)
          move_down(10)
        end

        stroke_color(black)
        line_width(3)
        line([index * 180, start_cursor], [index * 180, cursor + 10])
        stroke
      end

      move_down(20)
      stroke_color(light_gray)
      line_width(0.5)
      line([0, cursor], [523, cursor])
      stroke
      move_down(20)
    end

    def certification
      h2("certification")
      last_cursor = start_cursor = cursor

      config["certification"]&.each do |elem|
        bounding_box([15, cursor], width: 523) do
          text(elem["subject"], size: 9)
          text(elem["institution"], size: 9, style: :light)
          text(elem["date"], size: 7.5, color: dark_gray, style: :light)
          move_down(20)
        end

        stroke_color(black)
        line_width(3)
        line([2, start_cursor], [2, cursor + 20])
        stroke
      end
    end

    private

    def default_font_files
      {
        light: File.join("lib", "font", "Lato-Light.ttf"),
        normal: File.join("lib", "font", "Lato-Medium.ttf"),
        bold: File.join("lib", "font", "Lato-Bold.ttf")
      }
    end

    def h2(title)
      text(title&.upcase, style: :bold, size: 10, leading: 7, character_spacing: 1.9)
      line_width(1)
      stroke_color("000000")
      line([0, cursor], [35, cursor])
      move_down(15)
      stroke
      move_down(10)
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

    def print_current_bounds
      text("top: #{bounds.top}")
      text("left: #{bounds.left}")
      text("right: #{bounds.right}")
      text("bottom: #{bounds.bottom}")
    end
  end
end
