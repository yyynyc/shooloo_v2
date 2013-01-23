require 'spec_helper'

describe "StaticPages" do

	subject {page}

	shared_examples_for "all static pages" do
    it {should have_selector('h1', text: heading)}
    it {should have_selector('title', text: full_title(page_title))}
  end
  
  describe "home page" do
  	before {visit root_path} 
  	let(:heading) {'Shooloo Games'}
    let(:page_title) {''}

    it_should_behave_like "all static pages"
		it {should_not have_selector('title', text: ' | Home')}

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:post, user: user, question: "Lorem ipsum", answer: "whatever", grade: "5")
        FactoryGirl.create(:post, user: user, question: "Dolor sit amet", answer: "whatever", grade: "5")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.question, text: item.answer, text: item.grade)
        end
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
    click_link "Help"
    page.should have_selector('title', text: full_title('Help'))
    click_link "Contact"
    page.should have_selector('title', text: full_title('Contact'))
    click_link "Home"
    page.should have_selector('title', text: full_title(''))
    click_link "SHOOLOO GAMES"
    page.should have_selector('title', text: full_title(''))
  end
end
