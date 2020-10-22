require 'git'

require 'ghain/cli'
require 'ghain/git'
require 'ghain/graphql'
require 'ghain/pr'

module Ghain
  class << self
    def git
      @git ||= Git.open('.')
    end
  end
end
