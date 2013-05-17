require 'spec_helper'

describe Rating do
  let (:user) {FactoryGirl.create(:user)}
  let (:post) {FactoryGirl.create(:post)}
  before do 
  	@rating = user.ratings.build(answer_correctness: 1, 
  				steps: 1, 
  				grade_suitability: 1, 
  				overall_rating: true)
    @operations = @rating.operations.build
  	@rating.rated_post = post
  end

  subject {@rating}

  it {should respond_to(:rater_id, :rated_post_id,
  		:answer_correctness, :steps, :grade_suitability, 
  		:overall_rating, :improvements, :operations, :flags)}
  its(:rater) {should == user}
  its(:rated_post) {should == post}
  it {should be_valid}
end
