# frozen_string_literal: true

require_relative 'boxes_and_arrows/version'
require_relative 'boxes_and_arrows/html_renderer'
require_relative 'boxes_and_arrows/noko_renderer'

require 'hashie'

# Boxes and arrows is a framework to render simple, linear processes
# These processes are the common boxes followed by another single box
# connected by an arrow.
# This gem is, for now, tightly coupled to render a process which has
# a name, an upload information a user count and a list of roles or names.
# The intention is to use this gem for a specific project.
# Later on, with the passing of time and if interest comes into it, it can
# be forked and generalized.
module BoxesAndArrows
  class Error < StandardError; end
  class EmptyProcessList < StandardError; end
  # Your code goes here..

  def self.render(steps: [], box_classes: [], arrow_classes: [], grid_classes: [], method: :html)
    raise EmptyProcessList if steps.nil? || steps.empty?

    steps = steps.map { |s| Hashie::Mash.new(s) }
    render_klass = NokoRenderer
    render_klass = HTMLRenderer if method == :naive

    renderer = render_klass.new(steps:, box_classes:, arrow_classes:, grid_classes:)
    renderer.render
  end
end
