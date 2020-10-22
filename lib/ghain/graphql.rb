require 'json'
require 'open3'

# fragment pullInfo on PullRequest {
#   number
#   author {
#     login
#   }
#   headRefName
#   headRefOid
#   baseRefName
#   baseRefOid
# }

module Ghain
  class GraphQL
    PULL_INFO = <<~EOF
      fragment pullInfo on PullRequest {
        number
        author {
          login
        }
        headRefName
        headRefOid
        baseRefName
        baseRefOid
      }
    EOF

    class << self
      def query(query, **kwargs)
        args = [
          '-F', 'owner=:owner',
          '-F', 'repo=:repo',
          *kwargs.flat_map { |k,v| ['-F', "#{k}=#{v}"] },
          '-f', "query=#{query}"
        ]
        puts args
        out, err, stat = Open3.capture3('gh', 'api', 'graphql', *args)

        raise err unless stat.success?

        JSON.parse(out)
      end
    end
  end
end
