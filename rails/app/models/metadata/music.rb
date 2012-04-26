class Metadata::Music < Metadata
  serialize :track_listing
  
  validates :release_type, inclusion: { in: ["Album", "EP", "Single", "Compilation", "Remix"] }
  validates :release_year, numericality: { only_integer: true }
end
