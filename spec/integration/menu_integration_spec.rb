require_relative '../spec_helper'

describe "Menu Integration" do

#menu Texts
  let(:menu_text) do
<<EOS
What do you want to do?
1. Get a .gif
2. Give a .gif
EOS
  end
  let(:cat_defaults) do
<<EOS
1. Reaction
2. Abstract
EOS
  end
  let(:emo_defaults) do
<<EOS
1. Happy
2. Angry
3. Sad
4. Approval
5. Excitement
6. Sarcasm
7. Skepticism
8. Generic
EOS
  end
  let(:ref_defaults) do
<<EOS
1. Meme
2. Sports
3. Politics
EOS
  end

#start assertions
  context "the menu displays on startup" do
    let(:shell_output){ run_giffer_with_input() }
    it "should print the menu" do
      shell_output.should include(menu_text)
    end
  end
#refactored to stop menu if no gifs in DB
=begin
  context "the user selects 1" do
    let(:shell_output){ run_giffer_with_input("1") }
    it "should print the next menu" do
      shell_output.should include("What is your first criteria?")
    end
  end
=end
  context "the user selects 2" do
    let(:shell_output){ run_giffer_with_input("2") }
    it "should print the next menu" do
      shell_output.should include("Enter your url:")
    end
  end
  context "if the user types in the wrong input" do
    let(:shell_output){ run_giffer_with_input("4") }
    it "should print the menu again" do
      shell_output.should include_in_order(menu_text, "4", menu_text)
    end
    it "should include an appropriate error message" do
      shell_output.should include("'4' is not a valid selection")
    end
  end
  context "if the user types in no input" do
    let(:shell_output){ run_giffer_with_input("") }
    it "should print the menu again" do
      shell_output.should include_in_order(menu_text, menu_text)
    end
    it "should include an appropriate error message" do
      shell_output.should include("'' is not a valid selection")
    end
  end
  context "if the user types in incorrect input, it should allow correct input" do
    let(:shell_output){ run_giffer_with_input("4", "2") }
    it "should include the appropriate menu" do
      shell_output.should include("Enter your url:")
    end
  end
  context "if the user types in incorrect input multiple times, it should allow correct input" do
    let(:shell_output){ run_giffer_with_input("4","", "2") }
    it "should include the appropriate menu" do
      shell_output.should include("Enter your url:")
    end
  end

  context "the get menu should exit if there are no gifs in the DB" do
    let(:shell_output){run_giffer_with_input("1")}
    it "should include the appropriate message" do
      shell_output.should include ("No gifs in database. Please insert one first.")
    end
  end
  context "the get menu should cylce through the different tag options" do
    let(:shell_output){run_giffer_with_input("1", "1", "1", "1", "1")}
    before do
      Gif.new("bar.gif", "reaction", "angry", "bar").save
    end
    it "should include the appropriate menu" do
      shell_output.should include ("finish menu and open links")
    end
  end
  context "the get menu should cylce through the different tag options" do
    let(:shell_output){run_giffer_with_input("1", "2", "1", "1", "1")}
    before do
      Gif.new("bar.gif", "reaction", "angry", "bar").save
    end
    it "should include the appropriate menu" do
      shell_output.should include ("finish menu and open links")
    end
  end
  context "the get menu should cylce through the different tag options" do
    let(:shell_output){run_giffer_with_input("1", "3", "1", "1", "1")}
    before do
      Gif.new("bar.gif", "reaction", "angry", "bar").save
    end
    it "should include the appropriate menu" do
      shell_output.should include ("finish menu and open links")
    end
  end

  context "the give menu should cylce through the different tag options" do
    let(:shell_output){run_giffer_with_input("2", "url", "1", "1", "1")}
    it "should include the appropriate menu" do
      shell_output.should include ("finish menu and open links")
    end
  end
  context "the give menu should cylce through the different tag options and allow new tags" do
    let(:shell_output){run_giffer_with_input("2", "url", "x", "reaction", "x", "approval", "x", "batman")}
    it "should include the appropriate menu" do
      shell_output.should include ("finish menu and open links")
    end
  end

  context "the give menu should show default tags" do
    let(:shell_output){run_giffer_with_input("2", "url", "1", "1", "1")}
    it "should include the appropriate menu" do
      shell_output.should include (cat_defaults)
      shell_output.should include (emo_defaults)
      shell_output.should include (ref_defaults)
    end
  end

end

