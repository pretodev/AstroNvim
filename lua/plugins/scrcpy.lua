return {
  {
    "pretodev/scrcpy.nvim",
    cmd = { "ScrcpyMirror", "ScrcpyRecordStart", "ScrcpyRecordStop" },
    config = function() require("scrcpy").setup {} end,
  },
}
