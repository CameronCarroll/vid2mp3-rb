require "minitest/spec"
require "minitest/autorun"
require "minitest/unit"

require_relative "../lib/parser"
require 'uri'
require 'cgi'

URL = "https://www.youtube.com/watch?v=bnlFuPRxH8w"
ID = "bnlFuPRxH8w"
TRASH = "trash"

describe Parser do

  describe "passing no arguments" do
    describe "when default behavior is 'add'" do
      before do
        Parser::DEFAULT_BEHAVIOR = :add
        ARGV.replace []
      end

      it "should return video id in opts given an id" do
        def Parser.get_input; ID end
        opts = Parser.parse_options
        check_add opts
      end

      it "should return video id in opts given a url" do
        def Parser.get_input; URL end
        opts = Parser.parse_options
        check_add opts
      end

      it "should throw an ArgumentError given nothing" do
        def Parser.get_input; "" end
        assert_raises(ArgumentError) {Parser.parse_options}
      end
    end

    describe "when default behavior is 'download'" do
      before do
        Parser::DEFAULT_BEHAVIOR = :download
        ARGV.replace []
      end

      it "should return video id in opts given an id" do
        def Parser.get_input; ID end
        
        opts = Parser.parse_options
        check_download opts
      end

      it "should return video id in opts given a url" do
        def Parser.get_input; URL end
        opts = Parser.parse_options
        check_download opts
      end
    end
  end

  #----------------------------------------------------------------------------
  
  describe "passing url as only argument" do
    describe "when default behavior is 'download'" do
      before do
        ARGV.replace [URL]
        Parser::DEFAULT_BEHAVIOR = :download
      end

      it "should return video id in opts" do
        opts = Parser.parse_options
        check_download opts
      end
    end

    describe "when default behavior is 'add'" do
      before do
        ARGV.replace [URL]
        Parser::DEFAULT_BEHAVIOR = :add
      end

      it "should return video id in opts" do
        opts = Parser.parse_options
        check_add opts
      end
    end
    
  end

  #
  
  describe "passing id as only argument" do
    describe "when default behavior is 'download'" do
      before do
        ARGV.replace [ID]
        Parser::DEFAULT_BEHAVIOR = :download
      end

      it "should return video id in opts" do
        opts = Parser.parse_options
        check_download opts
      end
    end

    describe "when default behavior is 'add'" do
      before do
        ARGV.replace [ID]
        Parser::DEFAULT_BEHAVIOR = :add
      end

      it "should return video id in opts" do
        opts = Parser.parse_options
        check_add opts
      end
    end
    
  end

  #----------------------------------------------------------------------------

  describe "passing download command as first argument" do
    it "should throw an error with no additional arguments" do
      ARGV.replace ["download"]
      assert_raises(ArgumentError) {Parser.parse_options}
    end

    it "should throw an error if second argument is neither a URL nor 11 characters" do
      ARGV.replace ["download", TRASH]
      assert_raises(ArgumentError) {Parser.parse_options}
    end

    it "should add video id to opts given a url" do
      ARGV.replace ["download", URL]
      opts = Parser.parse_options
      check_download opts
    end

    it "should add video id to opts given an id" do
      ARGV.replace ["download", ID]
      opts = Parser.parse_options
      check_download opts
    end
  end

  #----------------------------------------------------------------------------

  describe "passing add command as first argument" do
    it "should throw an error with no additional arguments" do
      ARGV.replace ["add"]
      assert_raises(ArgumentError) {Parser.parse_options}
    end

    it "should throw an error if second argument is neither a URL nor 11 characters" do
      ARGV.replace ["add", TRASH]
      assert_raises(ArgumentError) {Parser.parse_options}
    end

    it "should add video id to opts given a url" do
      ARGV.replace ["add", URL]
      opts = Parser.parse_options
      check_add opts
    end

    it "should add video id to opts given an id" do
      ARGV.replace ["add", ID]
      opts = Parser.parse_options
      check_add opts
    end
  end

  #----------------------------------------------------------------------------

  describe "passing flag commands (version, execute, help) as first argument" do
    it "'execute' should add execute flag to opts and ignore extra args" do
      ARGV.replace ["execute", TRASH]
      opts = Parser.parse_options
      correct_opts = {:execute=>true}
      opts.must_equal correct_opts
    end

    it "'version' should add version flag to opts and ignore extra args" do
      ARGV.replace ["version", TRASH]
      opts = Parser.parse_options
      correct_opts = {:version=>true}
      opts.must_equal correct_opts
    end

    it "'help' should add help flag to opts and ignore extra args" do
      ARGV.replace ["help", TRASH]
      opts = Parser.parse_options
      correct_opts = {:help=>true}
      opts.must_equal correct_opts
    end
  end

  #----------------------------------------------------------------------------

  describe "passing an invalid command as first argument" do
    it "should throw an ArgumentError" do
      ARGV.replace ["unknown"]
      assert_raises(ArgumentError) {Parser.parse_options}
    end
  end
end

def check_add(opts)
  correct_opts = {:add=>ID}
  opts.must_equal correct_opts
end

def check_download(opts)
  correct_opts = {:download=>ID}
  opts.must_equal correct_opts
end