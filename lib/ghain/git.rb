require 'open3'

module Ghain
  module Git
    class << self
      def current_branch
        branch_name('HEAD')
      end

      def branch_name(ref = 'HEAD')
        git('symbolic-ref', '--quiet', '--short', ref)
      end

      private

      def git(*args)
        out, err, stat = Open3.capture3('git', *args)

        raise err unless stat.success?

        out.chomp
      end
    end
  end
end
