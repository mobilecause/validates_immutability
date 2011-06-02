require 'spec_helper'

class Widget4 < ActiveRecord::Base
  set_table_name :widgets
  validates :attr1, :immutable => true
end

describe Widget4, "validations" do
  context "when persisted" do
    subject { Widget4.create! }
  
    context "when attr1 is changed" do
      before do
        subject.attr1 = "changed"
        subject.valid?
        p subject.errors
      end
    
      it { should be_invalid }
      it { subject.errors.full_messages.should == ["Attr1 can't be modified"] }
    end
    
    context "when attr1 is not changed" do
      it { should be_valid }
    end
  end
  
  context "when new" do
    subject { Widget4.new }
    ["change", nil].each do |value|
      context "when attr1 is #{value ? 'changed' : 'not changed'}" do
        before { subject.attr1 = value if value }
        it { should be_valid }
      end
    end
  end
end

##################################################

class Widget5 < ActiveRecord::Base
  set_table_name :widgets
  validates :attr1, :immutable => {:if => :validate_immutability}
  attr_accessor :validate_immutability
end

describe Widget5, "validations" do
  context "when persisted" do
    subject { Widget5.create! }
  
    context "when attr1 is changed" do
      before { subject.attr1 = "changed" }
      
      context "validate_immutability is true" do
        before do
          subject.validate_immutability = true
          subject.valid?
        end
        it { should be_invalid }
        it { subject.errors.full_messages.should == ["Attr1 can't be modified"] }
      end
      
      context "validate_immutability is not true" do
        before { subject.validate_immutability = false }
        it { should be_valid }
      end
    end
    
    context "when attr1 is not changed" do
      [true, false, nil].each do |value|
        context "validate_immutability is #{value}" do
          before { subject.validate_immutability = value }
          it { should be_valid }
        end
      end
    end
  end
  
  context "when new" do
    subject { Widget5.new }
    
    ["changed", nil].each do |value|
      context "when attr1 is #{value ? 'changed' : 'not changed'}" do
        before { subject.attr1 = value }
        [true, false, nil].each do |value|
          context "validate_immutability is #{value}" do
            before { subject.validate_immutability = value }
            it { should be_valid }
          end
        end
      end
    end
  end
end

##################################################

class Widget6 < ActiveRecord::Base
  set_table_name :widgets
  validates :attr1, :immutable => {:message => "is frozen!"}
end

describe Widget6, "validations" do
  context "when persisted" do
    subject { Widget6.create! }
  
    context "when attr1 is changed" do
      before do
        subject.attr1 = "changed"
        subject.valid?
      end
    
      it { should be_invalid }
      it { subject.errors.full_messages.should == ["Attr1 is frozen!"] }
    end
    
    context "when attr1 is not changed" do
      it { should be_valid }
    end
  end
  
  context "when new" do
    subject { Widget6.new }
    ["change", nil].each do |value|
      context "when attr1 is #{value ? 'changed' : 'not changed'}" do
        before { subject.attr1 = value if value }
        it { should be_valid }
      end
    end
  end
end