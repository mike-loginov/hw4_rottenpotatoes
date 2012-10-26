Feature: User can manually delete movies

Scenario: Add a movie, then delete it
  Given I have added "MyMovie" with rating "R"
  And I am on the RottenPotatoes home page
  Then I should see "More about MyMovie"
  When I delete the movie "MyMovie"
  And I am on the RottenPotatoes home page
  Then I should not see "More about MyMovie"
