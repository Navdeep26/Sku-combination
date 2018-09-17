Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '281804859095455', 'b357880f24451c4138f631ead80e4ec5'
  provider :twitter, "dItXXjYF5LakbFX8XxxOQFMAu", "S661uaz9Eo4NHOVr03SxwaV13nL6cWczN8EFVNKLns1XOzZvzi"
  # provider :google, "65DeRv6Phnrt05gxzcrent2Amu", "Rft3421Ptgv78Gtyr30hgrmzxteq56mnErp"
end
