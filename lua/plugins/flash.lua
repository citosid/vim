require("flash").setup({
  keys = {
    "r",
    mode = "o",
    function()
      require("flash").treesitter_search()
    end,
    desc = "Flash Treesitter Search",
  },
  {
    "R",
    mode = "o",
    function()
      require("flash").remote()
    end,
    desc = "Flash Remote",
  },
})
