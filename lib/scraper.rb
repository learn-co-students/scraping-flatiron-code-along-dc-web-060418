require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    doc = Nokogiri::HTML(html)
  end

  def get_courses
    self.get_page.css("#course-grid .posts-holder .post:not(.empty-event)")
  end

  def make_courses 
    get_courses.map do |course|
      c = Course.new
      c.title = course.children[3].children.text
      c.schedule = course.children[5].children.text
      c.description = course.children[7].children.text
      c

    end 
  end 
  
end



