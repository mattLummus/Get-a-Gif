require_relative '../spec_helper'

describe Gif do
  context ".all" do
    context "with no gifs in the database" do
      it "should return an empty array" do
        Gif.all.should == []
      end
    end
    context "with multiple gifs in the database" do
      let(:foo){ Gif.new("foo.gif", "happy", "foo") }
      let(:bar){ Gif.new("bar.gif", "angry", "bar") }
      let(:baz){ Gif.new("baz.gif", "generic", "baz") }
      before do
        foo.save
        bar.save
        baz.save
      end
      it "should return all of the gifs with their attributes and ids" do
        gif_attrs = Gif.all.map{ |gif| [gif.url, gif.emotion, gif.reference, gif.id] }
        gif_attrs.should == [["foo.gif", "happy", "foo", foo.id],
                                ["bar.gif", "angry", "bar", bar.id],
                                ["baz.gif", "generic", "baz", baz.id]]
      end
    end
  end

  context ".count" do
    context "with no injuries in the database" do
      it "should return 0" do
        Gif.count.should == 0
      end
    end
    context "with multiple injuries in the database" do
      before do
      Gif.new("foo.gif", "happy", "foo").save
      Gif.new("bar.gif", "angry", "bar").save
      Gif.new("baz.gif", "generic", "baz").save
      end
      it "should return the correct count" do
        Gif.count.should == 3
      end
    end
  end

  context ".find_by_tag" do
    context "with no gifs in the database" do
      it "should return 0" do
        Gif.find_by_tag("emotion", "happy")[0].should be_nil
      end
    end
    context "with gif by that tag in the database" do
      let(:baz){ Gif.new("baz.gif", "generic", "baz") }
      before do
        baz.save
        Gif.new("bar.gif", "angry", "baz").save
        Gif.new("foo.gif", "happy", "foo").save
      end
      it "should return the gif with that category" do
        Gif.find_by_tag("emotion", "generic")[0].url.should == "baz.gif"
      end
      it "should populate the id" do
        Gif.find_by_tag("emotion", "generic")[0].id.should == baz.id
      end
      it "should return multiple gifs with the matching reference" do
        Gif.find_by_tag("reference", "baz").length.should == 2
      end
      it "should return the gif with the matching reference" do
        Gif.find_by_tag("reference", "baz")[0].id.should == baz.id
      end
    end
  end

  context ".last" do
    context "with no gifs in the database" do
      it "should return 0" do
        Gif.find_by_tag("emotion", "happy")[0].should be_nil
      end
    end
    context "with gif by that tag in the database" do
      let(:baz){ Gif.new("baz.gif", "generic", "baz") }
      before do
        Gif.new("bar.gif", "angry", "baz").save
        Gif.new("foo.gif", "happy", "foo").save
        baz.save
      end
      it "should return the last one inserted" do
        Gif.last.url.should == "baz.gif"
      end
      it "should return the last one inserted with id populated" do
        Gif.last.id.should == baz.id
      end
    end
  end

=begin
  context "#valid?" do
    let(:result){ Environment.database_connection.execute("Select name from injuries") }
    context "after fixing the errors" do
      let(:injury){ Injury.new("123") }
      it "should return true" do
        injury.valid?.should be_false
        injury.name = "Bob"
        injury.valid?.should be_true
      end
    end
    context "with a unique name" do
      let(:injury){ Injury.new("impalement, 1/2 - 2 inches diameter") }
      it "should return true" do
        injury.valid?.should be_true
      end
    end
    context "with a invalid name" do
      let(:injury){ Injury.new("420") }
      it "should return false" do
        injury.valid?.should be_false
      end
      it "should save the error messages" do
        injury.valid?
        injury.errors.first.should == "'420' is not a valid injury name, as it does not include any letters."
      end
    end
    context "with a duplicate name" do
      let(:injury){ Injury.new("impalement, 1/2 inch diameter or smaller") }
      before do
        Injury.new("impalement, 1/2 inch diameter or smaller").save
      end
      it "should return false" do
        injury.valid?.should be_false
      end
      it "should save the error messages" do
        injury.valid?
        injury.errors.first.should == "impalement, 1/2 inch diameter or smaller already exists."
      end
    end
  end
=end
end
