require 'spec_helper'

describe ValidatesImmutability::ImmutableValidator do
  subject { ValidatesImmutability::ImmutableValidator.new(@options) }
  before { @options = {:attributes => [:name]} }
  
  it { should be_a(ActiveModel::EachValidator) }
  
  describe "#validate_each" do
    before do
      @errors = []
      @record = mock(Object,
        :errors => mock(Object),
        :name_changed? => true,
        :new_record? => true
      )
      @record.errors.stub(:add) do |attr, msg|
        @errors << [attr, msg]
      end
    end
    
    context "when the attribute changed" do
      context "when record is new" do
        it "doesn't add any errors" do
          subject.validate_each(@record, :name, 'foo')
          @errors.should be_empty
        end
      end
      
      context "when record is not new" do
        before { @record.stub(:new_record?) { false } }
        it "adds an error" do
          subject.validate_each(@record, :name, 'foo')
          @errors.should == [[:name, "can't be modified"]]
        end
      end
    end
    
    context "when the attribute did not change" do
      before { @record.stub(:name_changed?) { false } }
      it "doesn't add any errors" do
        subject.validate_each(@record, :name, 'foo')
        @errors.should be_empty
      end
    end
  end
end