-------------------- telescope ----------------------------
local action_layout = require("telescope.actions.layout")
require("telescope").setup{
  defaults = {
    mappings = {
    },
   }, 
  pickers = {
    theme = "ivy"
  }
}
require("telescope").setup()
