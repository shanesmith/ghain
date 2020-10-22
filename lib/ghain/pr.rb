# frozen_string_literal: true

module Ghain
  class PR
    def initialize(info)
      @info = info
    end

    class << self
      def from_base_branch(branch)
        result = Ghain::GraphQL.query(<<~QUERY, branch: branch)
          #{Ghain::GraphQL::PULL_INFO}

          query($owner: String!, $repo: String!, $branch: String!) { 
            repository(owner: $owner, name: $repo) {
              pullRequests(baseRefName: $branch, first: 100) {
                nodes {
                  ...pullInfo
                }
              }
            }
          }
        QUERY


        nodes = result.dig('data', 'repository', 'pullRequests', 'nodes')

        nodes.map { |info| Ghain::PR.new(info) }
      end
    end
  end
end
