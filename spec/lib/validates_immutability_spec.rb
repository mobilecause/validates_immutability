require 'spec_helper'

class Widget1 < ActiveRecord::Base
  set_table_name :widgets
end

describe Widget1, ".immutable" do
  it "calls .validate" do
    Widget1.should_receive(:validate).with(:a => 1, :b => 2, :on => :update)
    Widget1.immutable(:a => 1, :b => 2, :message => 'some message')
  end
  
  context "when :on is given" do
    it "raises an ArgumentError" do
      lambda do
        Widget1.immutable(:on => :create)
      end.should raise_error(ArgumentError, "Unknown option :on")
    end
  end
end

##################################################

class Widget2 < ActiveRecord::Base
  set_table_name :widgets
  immutable :message => 'My message'
end

describe Widget2, "validations" do
  context "when persisted" do
    subject { Widget2.create! }
  
    context "when changed" do
      before do
        subject.attr1 = "changed"
        subject.valid?
      end
    
      it { should be_invalid }
      it { subject.errors.full_messages.should == ['My message'] }
    end
    
    context "when not changed" do
      before { subject.valid? }
      it { should be_valid }
    end
  end
  
  context "when new" do
    subject { Widget2.new }
    
    context "when changed" do
      before do
        subject.attr1 = "changed"
        subject.valid?
      end      
      it { should be_valid }
    end
    
    context "when not changed" do
      before { subject.valid? }
      it { should be_valid }
    end
  end
end

##################################################

class Widget3 < ActiveRecord::Base
  set_table_name :widgets
  immutable
end

describe Widget3, "validations" do
  context "when persisted and changed" do
    subject { Widget3.create! }
    before do
      subject.attr1 = "changed"
      subject.valid?
    end
    
    it { should_not be_valid }
    it { subject.errors.full_messages.should == ["Updates are not allowed."] }
  end
end