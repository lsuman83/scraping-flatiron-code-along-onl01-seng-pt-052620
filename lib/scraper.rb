require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page

    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    
  end

  def get_courses

    self.get_page.css(".post")

  end

  def make_courses

    get_courses.each do |courses|
      course = Course.new
      course.title = courses.css("h2").text
      course.schedule = courses.css(".date").text
      course.description = courses.css("p").text
    end

  
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  
  
end


Scraper.new.print_courses

