safe_require('nvim-tree', {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = false,
    add_trailing = false,
    full_name = false,
    root_folder_modifier = ':~',
    indent_markers = {
        enable = false,
        icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
        },
    },
  },
  filters = {
    dotfiles = true,
  },
})

map("n", "<Leader>t", ":NvimTreeFindFileToggle<CR>")
