require 'spec_helper'

describe "routing to the similar movies by director" do
  it "routes /movies/:id/similar to movies#similar" do
    { :get => "movies/2/similar" }.should route_to(
      :controller => "movies",
      :action => "similar",
      :id => "2"
    )
  end  
end
