require 'nokogiri'
require 'open-uri'

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
#---this grabes the page in a hash
    #doc =
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

#---creating the elements here:
#this firs line grabs the hash and selects each one which is each class_info
  # doc.css(".post").each do |post|
  #   # creates a new course and then assigns the values
  #   course = Course.new
  #   course.title = post.css("h2").text
  #   course.schedule = post.css(".date").text
  #   course.description = post.css("p").text
  #   binding.pry
  # end

    # code for title: doc.css(".post").css("h2").text

    # code for dates:
    # doc.css(".post").css(".date").text

    # code for course description:
    # doc.css(".post").css("p").text
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end



end


Scraper.new.print_courses
