Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_movie = Movie.create(movie)
    new_movie.should_not == nil
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_title, director|
  steps %Q{
    Then I should see "Details about #{movie_title}"
    And I should see "#{director}"
  }
end

Then /I should see all the movies/ do
  page.all('table#movies tbody tr').count.should == 10
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  res1 = ( page.body =~ /#{Regexp.quote(e1)}/ )
  res2 = ( page.body =~ /#{Regexp.quote(e2)}/ )
  res1.should_not be nil
  res2.should_not be nil 
  res1.should be < res2  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{,\s*}).each do |rating|
    if uncheck == "un"
      steps %Q{
        When I uncheck "#{'ratings_'+rating}"
      }
    else
      steps %Q{
        When I check "#{'ratings_'+rating}"
      }
    end
  end
end

Given /I have added "(.*)" with rating "(.*)"/ do |title, rating|
  steps %Q{
    Given I am on the Create New Movie page
    When I fill in "Title" with "#{title}"
    And I select "#{rating}" from "Rating"
    And I press "Save Changes"
  }
end

When /I delete the movie "(.*)"/ do |title|
  steps %Q{
    Given I am on the RottenPotatoes home page
    When I follow "More about #{title}"
    Then I should see "Details about #{title}"
    And I press "Delete"
  }
end
