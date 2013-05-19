require 'spec_helper'

describe Rating do
  let (:user) {FactoryGirl.create(:user)}
  let(:poster) {FactoryGirl.create(:user)}
  let (:post) {FactoryGirl.create(:post, user: poster)}
  
  subject {@rating}

<<<<<<< HEAD
  it {should respond_to(:rater_id, :rated_post_id,
  		:answer_correctness, :steps, :grade_suitability, 
  		:overall_rating, :improvements, :operations, :flags)}
  its(:rater) {should == user}
  its(:rated_post) {should == post}
  it {should be_valid}

  describe "accessible attributes" do
    it "should not allow access to rater_id" do
      expect do
        Rating.new(rater_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end   

    it "should not allow access to rated_post_id" do
      expect do
        Rating.new(rated_post_id: post.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end  
  end

  describe "when rater is not present" do
    before { @rating.rater_id = nil }
    it { should_not be_valid }
  end

  describe "when rated_post is not present" do
    before { @rating.rated_post_id = nil }
    it { should_not be_valid }
  end

  describe "when none of the math operations is chosen" do
    before { @rating.operations = [] }
    it { should_not be_valid }
  end

  describe "when answer_correctness is not present" do
    before { @rating.answer_correctness = nil }
    it { should_not be_valid }
  end

  describe "when the number of solution steps is not present" do
    before { @rating.steps = nil }
    it { should_not be_valid }
  end

  describe "when grade suitability is not present" do
    before { @rating.grade_suitability = nil }
    it { should_not be_valid }
  end

  describe "when overall_rating is not present" do
    before { @rating.overall_rating = nil }
    it { should_not be_valid }
=======
  describe "a user rate someone else's post" do
    before do 
      @rating = user.ratings.build(answer_correctness: 1, 
            steps: 1, 
            grade_suitability: 1, 
            overall_rating: true)
      @operations = @rating.operations.build
      @rating.rated_post = post
    end

    it {should respond_to(:rater_id, :rated_post_id,
        :answer_correctness, :steps, :grade_suitability, 
        :overall_rating, :improvements, :operations, :flags)}
    its(:rater) {should == user}
    its(:rated_post) {should == post}
    it {should be_valid}

    describe "accessible attributes" do
      it "should not allow access to rater_id" do
        expect do
          Rating.new(rater_id: user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end 
    end  

    describe "when rater is not present" do
      before { @rating.rater_id = nil }
      it { should_not be_valid }
    end

    describe "when rated_post is not present" do
      before { @rating.rated_post_id = nil }
      it { should_not be_valid }
    end

    describe "when none of the math operations is chosen" do
      before { @rating.operations = [] }
      it { should_not be_valid }
    end

    describe "when answer_correctness is not present" do
      before { @rating.answer_correctness = nil }
      it { should_not be_valid }
    end

    describe "when the number of solution steps is not present" do
      before { @rating.steps = nil }
      it { should_not be_valid }
    end

    describe "when grade suitability is not present" do
      before { @rating.grade_suitability = nil }
      it { should_not be_valid }
    end

    describe "when overall_rating is not present" do
      before { @rating.overall_rating = nil }
      it { should_not be_valid }
    end
>>>>>>> test-fixing
  end
end

