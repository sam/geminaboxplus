require "boot"

class Geminabox

  private

  def reindex
    Geminabox.fixup_bundler_rubygems!
    Resque.enqueue(Reindexer, settings)
  end
end

Geminabox.data = (ENV["GEMINABOX_DATA"] || "/var/www/data")

run Rack::URLMap.new("/" => Geminabox, "/resque" => Resque::Server.new)
