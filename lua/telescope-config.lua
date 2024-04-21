-------------------- telescope ----------------------------
local M = {}
local theme = require('telescope.themes').get_dropdown()
local builtin = require('telescope.builtin')

function M.find_files()
  builtin.find_files(theme)
end
function M.live_grep()
  builtin.live_grep(theme)
end
function M.grep_string()
  builtin.grep_string(theme)
end
function M.fd()
  builtin.fd(theme)
end
function M.treesitter()
  builtin.treesitter(theme)
end
function M.current_buffer_fuzzy_find()
  builtin.current_buffer_fuzzy_find(theme)
end
function M.tags()
  builtin.tags(theme)
end
function M.current_buffer_tags()
  builtin.current_buffer_tags(theme)
end
function M.git_files()
  builtin.git_files(theme)
end
function M.git_commits()
  builtin.git_commits(theme)
end
function M.git_bcommits()
  builtin.git_bcommits(theme)
end
function M.git_bcommits_range()
  builtin.git_bcommits_range(theme)
end
function M.git_branches()
  builtin.git_branches(theme)
end
function M.git_status()
  builtin.git_status(theme)
end
function M.git_stash()
  builtin.git_stash(theme)
end
function M.builtin()
  builtin.builtin(theme)
end
function M.resume()
  builtin.resume(theme)
end
function M.pickers()
  builtin.pickers(theme)
end
function M.planets()
  builtin.planets(theme)
end
function M.symbols()
  builtin.symbols(theme)
end
function M.commands()
  builtin.commands(theme)
end
function M.quickfix()
  builtin.quickfix(theme)
end
function M.quickfixhistory()
  builtin.quickfixhistory(theme)
end
function M.loclist()
  builtin.loclist(theme)
end
function M.oldfiles()
  builtin.oldfiles(theme)
end
function M.command_history()
  builtin.command_history(theme)
end
function M.search_history()
  builtin.search_history(theme)
end
function M.vim_options()
  builtin.vim_options(theme)
end
function M.help_tags()
  builtin.help_tags(theme)
end
function M.man_pages()
  builtin.man_pages(theme)
end
function M.reloader()
  builtin.reloader(theme)
end
function M.buffers()
  builtin.buffers(theme)
end
function M.colorscheme()
  builtin.colorscheme(theme)
end
function M.marks()
  builtin.marks(theme)
end
function M.registers()
  builtin.registers(theme)
end
function M.keymaps()
  builtin.keymaps(theme)
end
function M.filetypes()
  builtin.filetypes(theme)
end
function M.highlights()
  builtin.highlights(theme)
end
function M.autocommands()
  builtin.autocommands(theme)
end
function M.spell_suggest()
  builtin.spell_suggest(theme)
end
function M.tagstack()
  builtin.tagstack(theme)
end
function M.jumplist()
  builtin.jumplist(theme)
end
function M.lsp_references()
  builtin.lsp_references(theme)
end
function M.lsp_incoming_calls()
  builtin.lsp_incoming_calls(theme)
end
function M.lsp_outgoing_calls()
  builtin.lsp_outgoing_calls(theme)
end
function M.lsp_definitions()
  builtin.lsp_definitions(theme)
end
function M.lsp_type_definitions()
  builtin.lsp_type_definitions(theme)
end
function M.lsp_implementations()
  builtin.lsp_implementations(theme)
end
function M.lsp_document_symbols()
  builtin.lsp_document_symbols(theme)
end
function M.lsp_workspace_symbols()
  builtin.lsp_workspace_symbols(theme)
end
function M.lsp_dynamic_workspace_symbols()
  builtin.lsp_dynamic_workspace_symbols(theme)
end
function M.diagnostics()
  builtin.diagnostics(theme)
end
return M
