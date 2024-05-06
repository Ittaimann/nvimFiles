-------------------- telescope ----------------------------
local M = {}
local builtin = require('telescope.builtin')

function M.find_files()
  local theme = require('telescope.themes').get_dropdown()
  builtin.find_files(theme)
end
function M.live_grep()
  builtin.live_grep()
end
function M.grep_string()
  builtin.grep_string()
end
function M.fd()
  builtin.fd()
end
function M.treesitter()
  builtin.treesitter()
end
function M.current_buffer_fuzzy_find()
  builtin.current_buffer_fuzzy_find()
end
function M.tags()
  builtin.tags()
end
function M.current_buffer_tags()
  builtin.current_buffer_tags()
end
function M.git_files()
  builtin.git_files()
end
function M.git_commits()
  builtin.git_commits()
end
function M.git_bcommits()
  builtin.git_bcommits()
end
function M.git_bcommits_range()
  builtin.git_bcommits_range()
end
function M.git_branches()
  builtin.git_branches()
end
function M.git_status()
  builtin.git_status()
end
function M.git_stash()
  builtin.git_stash()
end
function M.builtin()
  builtin.builtin()
end
function M.resume()
  builtin.resume()
end
function M.pickers()
  builtin.pickers()
end
function M.planets()
  builtin.planets()
end
function M.symbols()
  builtin.symbols()
end
function M.commands()
  builtin.commands()
end
function M.quickfix()
  builtin.quickfix()
end
function M.quickfixhistory()
  builtin.quickfixhistory()
end
function M.loclist()
  builtin.loclist()
end
function M.oldfiles()
  builtin.oldfiles()
end
function M.command_history()
  builtin.command_history()
end
function M.search_history()
  builtin.search_history()
end
function M.vim_options()
  builtin.vim_options()
end
function M.help_tags()
  builtin.help_tags()
end
function M.man_pages()
  builtin.man_pages()
end
function M.reloader()
  builtin.reloader()
end
function M.buffers()
  builtin.buffers()
end
function M.colorscheme()
  builtin.colorscheme()
end
function M.marks()
  builtin.marks()
end
function M.registers()
  builtin.registers()
end
function M.keymaps()
  builtin.keymaps()
end
function M.filetypes()
  builtin.filetypes()
end
function M.highlights()
  builtin.highlights()
end
function M.autocommands()
  builtin.autocommands()
end
function M.spell_suggest()
  builtin.spell_suggest()
end
function M.tagstack()
  builtin.tagstack()
end
function M.jumplist()
  builtin.jumplist()
end
function M.lsp_references()
  builtin.lsp_references()
end
function M.lsp_incoming_calls()
  builtin.lsp_incoming_calls()
end
function M.lsp_outgoing_calls()
  builtin.lsp_outgoing_calls()
end
function M.lsp_definitions()
  builtin.lsp_definitions()
end
function M.lsp_type_definitions()
  builtin.lsp_type_definitions()
end
function M.lsp_implementations()
  builtin.lsp_implementations()
end
function M.lsp_document_symbols()
  builtin.lsp_document_symbols()
end
function M.lsp_workspace_symbols()
  builtin.lsp_workspace_symbols()
end
function M.lsp_dynamic_workspace_symbols()
  builtin.lsp_dynamic_workspace_symbols()
end
function M.diagnostics()
  builtin.diagnostics()
end
return M
