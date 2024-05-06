local M={}

function M.Scratch()
  local buf = vim.api.nvim_create_buf({},true)
  vim.api.nvim_buf_set_name(buf, 'scratch')
  vim.api.nvim_set_current_buf(buf)
  return buf
end

function M.getAllOptions()
  local table = vim.api.nvim_get_all_options_info()
  print(vim.inspect(table))
end

return M
