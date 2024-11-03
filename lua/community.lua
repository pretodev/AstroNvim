---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- comment
  { import = "astrocommunity.comment.mini-comment" },

  -- docker
  { import = "astrocommunity.docker.lazydocker" },

  -- packs
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.hyprlang" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  -- utility
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
}
