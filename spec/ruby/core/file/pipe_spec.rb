require_relative '../../spec_helper'
require_relative '../../shared/file/pipe'

describe "File.pipe?" do
  it_behaves_like :file_pipe, :pipe?, File
end

describe "File.pipe?" do
  it "returns false if file does not exist" do
    File.pipe?("I_am_a_bogus_file").should == false
  end

  it "returns false if the file is not a pipe" do
    filename = tmp("i_exist")
    touch(filename)

    File.pipe?(filename).should == false

    rm_r filename
  end

  platform_is_not :windows do
    it "returns true if the file is a pipe" do
      filename = tmp("i_am_a_pipe")
      File.mkfifo(filename)

      File.pipe?(filename).should == true

      rm_r filename
    end
  end
end
