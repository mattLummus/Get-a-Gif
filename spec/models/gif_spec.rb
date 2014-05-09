require_relative '../spec_helper'

describe Gif do
  context ".all" do
    context "with no gifs in the database" do
      it "should return an empty array" do
        Gif.all.should == []
      end
    end
    context "with multiple gifs in the database" do
      let(:foo){ Gif.new("foo.gif", "reaction", "happy", "foo") }
      let(:bar){ Gif.new("bar.gif", "reaction", "angry", "bar") }
      let(:baz){ Gif.new("baz.gif", "abstract", "generic", "baz") }
      before do
        foo.save
        bar.save
        baz.save
      end
      it "should return all of the gifs with their attributes and ids" do
        gif_attrs = Gif.all.map{ |gif| [gif.url, gif.category, gif.emotion, gif.reference, gif.id] }
        gif_attrs.should == [["foo.gif", "reaction", "happy", "foo", foo.id],
                                ["bar.gif", "reaction", "angry", "bar", bar.id],
                                ["baz.gif", "abstract", "generic", "baz", baz.id]]
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
      Gif.new("foo.gif", "reaction", "happy", "foo").save
      Gif.new("bar.gif", "reaction", "angry", "bar").save
      Gif.new("baz.gif", "abstract", "generic", "baz").save
      end
      it "should return the correct count" do
        Gif.count.should == 3
      end
    end
  end

  context ".find_by_tag" do
    context "with no gifs in the database" do
      it "should return 0" do
        Gif.find_by_tag("category", "reaction")[0].should be_nil
      end
    end
    context "with gif by that tag in the database" do
      let(:baz){ Gif.new("baz.gif", "abstract", "generic", "baz") }
      before do
        baz.save
        Gif.new("bar.gif", "reaction", "angry", "bar").save
        Gif.new("foo.gif", "reaction", "happy", "foo").save
      end
      it "should return the gif with that category" do
        Gif.find_by_tag("category", "abstract")[0].url.should == "baz.gif"
      end
      it "should populate the id" do
        Gif.find_by_tag("category", "abstract")[0].id.should == baz.id
      end
      it "should return multiple gifs with the matching category" do
        Gif.find_by_tag("category", "reaction").length.should == 2
      end
    end
  end

=begin
  context ".last" do
    context "with no injuries in the database" do
      it "should return nil" do
        Injury.last.should be_nil
      end
    end
    context "with multiple injuries in the database" do
      let(:grille){ Injury.new("Grille") }
      before do
        Injury.new("Foo").save
        Injury.new("Bar").save
        Injury.new("Baz").save
        grille.save
      end
      it "should return the last one inserted" do
        Injury.last.name.should == "Grille"
      end
      it "should return the last one inserted with id populated" do
        Injury.last.id.should == grille.id
      end
    end
  end

  context "#new" do
    let(:injury){ Injury.new("impalement, 1/2 inch diameter or smaller") }
    it "should store the name" do
      injury.name.should == "impalement, 1/2 inch diameter or smaller"
    end
  end

  context "#create" do
    let(:result){ Environment.database_connection.execute("Select * from injuries") }
    let(:injury){ Injury.create("foo") }
    context "with a valid injury" do
      before do
        Injury.any_instance.stub(:valid?){ true }
        injury
      end
      it "should record the new id" do
        result[0]["id"].should == injury.id
      end
      it "should only save one row to the database" do
        result.count.should == 1
      end
      it "should actually save it to the database" do
        result[0]["name"].should == "foo"
      end
    end
    context "with an invalid injury" do
      before do
        Injury.any_instance.stub(:valid?){ false }
        injury
      end
      it "should not save a new injury" do
        result.count.should == 0
      end
    end
  end

  context "#save" do
    let(:result){ Environment.database_connection.execute("Select * from injuries") }
    let(:injury){ Injury.new("foo") }
    context "with a valid injury" do
      before do
        injury.stub(:valid?){ true }
      end
      it "should only save one row to the database" do
        injury.save
        result.count.should == 1
      end
      it "should record the new id" do
        injury.save
        injury.id.should == result[0]["id"]
      end
      it "should actually save it to the database" do
        injury.save
        result[0]["name"].should == "foo"
      end
    end
    context "with an invalid injury" do
      before do
        injury.stub(:valid?){ false }
      end
      it "should not save a new injury" do
        injury.save
        result.count.should == 0
      end
    end
  end

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
