class Reindexer
  @queue = :reindex

  def self.perform(indexer, force_rebuild)
    if force_rebuild
      indexer.generate_index
    else
      begin
        indexer.update_index
      rescue => e
        puts "#{e.class}:#{e.message}"
        puts e.backtrace.join("\n")
        perform(indexer, true)
      end
    end
  end
end
