class Reindexer
  @queue = :reindex

  def self.perform(settings, force_rebuild=false)
    Geminabox.fixup_bundler_rubygems!
    indexer = Gem::Indexer.new(settings.data)

    force_rebuild = true unless settings.incremental_updates
    if force_rebuild
      indexer.generate_index
    else
      begin
        indexer.update_index
      rescue => e
        puts "#{e.class}:#{e.message}"
        puts e.backtrace.join("\n")
        perform(settings, :force_rebuild)
      end
    end
  end
end
