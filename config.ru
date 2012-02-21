require "boot"

class Geminabox

  private

  def reindex(force_rebuild = false)
    Geminabox.fixup_bundler_rubygems!
    force_rebuild = true unless settings.incremental_updates
    Resque.enqueue(Reindexer, indexer, force_rebuild)
  end
end

Geminabox.data = (ENV["GEMINABOX_DATA"] || "/var/www/data")

run Rack::URLMap.new("/" => Geminabox, "/resque" => Resque::Server.new)
