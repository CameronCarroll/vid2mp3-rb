# vid2mp3-rb -- Argument parser module
# Cameron Carroll, 2013-2014
# Purpose: Gets program commands and arguments out of ARGV and does some validation.

module Argparser
  NOT_VIDEO_ERROR_MSG = "You specified an argument which wasn't a URL or video ID."
  NO_QUERY_ERROR_MSG = "URL didn't contain a query. Are you sure it's a youtube video link?"
  NO_VIDARG_ERROR_MSG = "URL didn't contain a 'v=' argument. Are you sure it's a youtube video link?"
  INVALID_DEFAULT_ERROR_MSG = "DEFAULT_BEHAVIOR is defined incorrectly in user configuration section."

  def self.parse_options
    opts = {}

    def warn_extra_args(command)
      warn "Warning: You included extra arguments after #{command} which will be ignored."
    end

    command = ARGV.shift
    case command
    when /help/i, /-help/i, /info/i, /-info/i, /-h$/i
      opts[:help] = true
      warn_extra_args if ARGV[1]
    when /version/i, /-version/i, /-v$/i
      opts[:version] = true
      warn_extra_args if ARGV[1]
    when /download/i, /-download/i, /dl/i, /-dl/i, /-d$/i
      opts[:download] = get_video_id_from ARGV.first
    when /add/i, /-add/i, /-a/
      opts[:add] = get_video_id_from ARGV.first
    when /execute/i, /-execute/i, /-e$/i
      opts[:execute] = true
      warn_extra_args if ARGV[1]
    when /^http/i, /^www\./i, /.{11}/
      case DEFAULT_BEHAVIOR
      when :download
        opts[:download] = get_video_id_from command
      when :add
        opts[:add] = get_video_id_from command
      else
        warn INVALID_DEFAULT_ERROR_MSG
        opts[:help] = true
      end
    when nil
      id = get_id_from_user
      case DEFAULT_BEHAVIOR
      when :download
        opts[:download] = id
      when :add
        opts[:add] = id
      else
        warn INVALID_DEFAULT_ERROR_MSG
        opts[:help] = true
      end
    else
      raise ArgumentError, "That command isn't defined."
    end

    return opts
  end

  # Checks that ARGV[1] is either a URL with a ?v= argument or an 11-character youtube video ID.
  # And then returns that id.
  def self.get_video_id_from(input)
    if input
      return match(input)
    else
      raise ArgumentError, "You didn't specify a URL."
    end
  end

  def self.match(input)
    if input.match(/^http/i) || input.match(/^www\./i)
      id = parse_url(input)
    elsif input.length == 11
      id = input
    else
      raise ArgumentError, NOT_VIDEO_ERROR_MSG
    end

    return id
  end

  def self.parse_url(url)
    url = URI.parse(url)
    if url.query
      query = CGI.parse(url.query)
      if query.member?("v")
        return query["v"].first # video key is sitting in an array inside hash value
      else
        raise ArgumentError, NO_VIDARG_ERROR_MSG
      end
    else
      raise ArgumentError, NO_QUERY_ERROR_MSG
    end
  end

  def self.get_input
    print "Please paste Youtube video URL or video ID: "
    gets.chomp
  end

  def self.get_id_from_user
    input = get_input
    return match(input)
  end
end