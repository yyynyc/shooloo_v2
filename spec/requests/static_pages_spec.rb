require 'spec_helper'

describe "StaticPages" do

	subject {page}

	shared_examples_for "all static pages" do
    it {should have_selector('title', text: full_title(page_title))}
  end
  
  describe "home page" do
  	before {visit root_path} 
  	let(:heading) {'Shooloo'}
    let(:page_title) {''}

    it_should_behave_like "all static pages"
		it {should_not have_selector('title', text: ' | Home')}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:post, user: user, question: "Lorem ipsum", answer: "whatever", grade: "5th grade", category: "books")
        FactoryGirl.create(:post, user: user, question: "Dolor sit amet", answer: "whatever", grade: "6th grade", category: "shopping")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.question, text: item.grade)
        end
      end

      describe "follower/following count" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 members", href: following_user_path(user)) }
        it { should have_link("1 member", href: followers_user_path(user)) }
      end
    end
  end

  describe "help page" do
  	before {visit help_path} 
		let(:heading) {'Help'}
    let(:page_title) {'Help'}
    it_should_behave_like "all static pages"
  end

  describe "about page" do
  	before {visit about_path}
  	let(:heading) {'About'}
    let(:page_title) {'About'}
    it_should_behave_like "all static pages"
  end

  describe "contact page" do
  	before {visit contact_path}
  	let(:heading) {'Contact'}
    let(:page_title) {'Contact'} 
    it_should_behave_like "all static pages"	
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector('title', text: full_title('About'))
    click_link "Contact"
    page.should have_selector('title', text: full_title('Contact'))
    click_link "Home"
    page.should have_selector('title', text: full_title(''))
    click_link "SHOOLOO"
    page.should have_selector('title', text: full_title(''))
  end
end
