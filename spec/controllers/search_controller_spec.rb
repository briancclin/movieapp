require 'spec_helper'

describe SearchController do

  describe "GET 'result'" do
    it "returns http success" do
      get 'result'
      response.should be_success
    end
  end

end
