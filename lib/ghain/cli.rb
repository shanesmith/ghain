module Ghain
  class Cli
    class << self
      def start(_args)
        branch = Ghain::Git.current_branch
        puts Ghain::PR.from_base_branch(branch)
      end
    end
  end
end
