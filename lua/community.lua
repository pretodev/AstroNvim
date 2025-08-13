---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- comment
  { import = "astrocommunity.comment.mini-comment" },

  -- completion
  { import = "astrocommunity.completion.avante-nvim" },

  -- docker
  { import = "astrocommunity.docker.lazydocker" },

  -- editing support
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },

  -- packs
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.hyprlang" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.mdx" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.pkl" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },

  -- recipes
  { import = "astrocommunity.recipes.disable-tabline" },

  -- utility
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
}
