class Reindexer
  @queue = :reindex

  def self.perform(data)
    Geminabox.fixup_bundler_rubygems!
    Gem::Indexer.new(data).generate_index
  end
end
