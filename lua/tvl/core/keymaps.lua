local opts = { noremap = true, silent = true }
local Terminal  = require('toggleterm.terminal').Terminal
local Util = require("lazy.core.util")
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " 

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Run current file in terminal

function _runTerminal_toggle()

  local runTerminal = Terminal:new({ hidden=false, close_on_exit=false, direction="horizontal", count=1})

  runTerminal.on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<c-r>", "<cmd>close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "i", "<c-r>", "<cmd>close<CR>", {noremap = true, silent = true})
  end

  runTerminal.on_exit = function()
    vim.cmd("Neotree show")
  end

  local fname = vim.fn.expand("%")
  local cmd = GetExecutioner(fname)

  if type(cmd) == "table" then
    vim.cmd("Neotree show")
    Util.error(cmd.message, { title=cmd.title })
  else
    runTerminal.cmd = cmd
    runTerminal:toggle()
  end
end

keymap("i", "<c-r>", "<ESC>:Neotree close<CR><cmd>lua _runTerminal_toggle()<CR>", opts)
keymap("n", "<c-r>", ":Neotree close<CR><cmd>lua _runTerminal_toggle()<CR>", opts)

----------------- duplicate/remove current line ----------------
keymap("i", "<c-d>", "<ESC>Yp<Insert>", opts)
keymap("n", "<c-d>", "Yp", opts)
keymap("i", "<A-d>", "<ESC>dd<Insert>", opts)

----------------- Toggle Insert/Normal mode --------------------
keymap("i", "<c-x>", "<ESC>", opts)
keymap("n", "<c-x>", "<Insert>", opts)

-------------------- Save/Undo etc -----------------------------
keymap("i", "<c-s>", "<ESC>:w<CR><Insert>", opts) --save
keymap("n", "<c-s>", ":w<CR>", opts) --save

keymap("i", "<c-z>", "<ESC><C-G>:u<CR><Insert>", opts) --undo
keymap("n", "<c-z>", "<C-G>:u<CR>", opts) --undo

keymap("i", "<c-y>", "<ESC>:redo<CR><Insert>", opts) --redo
keymap("n", "<c-y>", ":redo<CR>", opts) --redo


-------------------- Toggle Neotree ----------------------------
keymap("n","<S-t>", ":Neotree toggle<CR>", opts)

-------------------- Better window navigation ------------------
keymap("n", "<c-h>", "<c-w>h", opts)
keymap("n", "<c-l>", "<c-w>l", opts)
keymap("n", "<c-j>", "<c-w>j", opts)
keymap("n", "<c-k>", "<c-w>k", opts)

-------------------- Navigate buffers --------------------------
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<A-S-l>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<A-S-h>", ":BufferLineMovePrev<CR>", opts)

-------------------- Press jk fast to enter --------------------
keymap("i", "jk", "<ESC>", opts)
keymap("i", "Jk", "<ESC>", opts)
keymap("i", "jK", "<ESC>", opts)
keymap("i", "JK", "<ESC>", opts)

-------------------- Stay in indent mode ------------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts)

-------------------- Resize windows ----------------------------
keymap("n", "<A-C-j>", ":resize +1<CR>", opts)
keymap("n", "<A-C-k>", ":resize -1<CR>", opts)
keymap("n", "<A-C-h>", ":vertical resize +1<CR>", opts)
keymap("n", "<A-C-l>", ":vertical resize -1<CR>", opts)

-------------------- Move text up/ down ------------------------
-- Visual --
keymap("v", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-S-k>", ":m .-2<CR>==", opts)
-- Block --
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-S-k>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
keymap("n", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-S-k>", ":m .-2<CR>==", opts)
-- Insert --
keymap("i", "<A-S-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-S-k>", "<ESC>:m .-2<CR>==gi", opts)

-------------------- No highlight ------------------------------
keymap("n", ";", ":noh<CR>", opts)

-------------------- Go to buffer quickly ----------------------
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-------------------- split window ------------------------------
keymap("n", "<leader>\\", ":vsplit<CR>", opts)
keymap("n", "<leader>/", ":split<CR>", opts)

-------------------- Switch two windows ------------------------
keymap("n", "<A-o>", "<C-w>r", opts)

-------------------- Ranger --------------------------------
keymap("n", "<leader>o", ":RnvimrToggle<CR>", opts)

-------------------- Compile --------------------------------
keymap("n", "<c-m-n>", "<cmd>only | Compile<CR>", opts)

-------------------- Inspect --------------------------------
keymap("n", "<F2>", "<cmd>Inspect<CR>", opts)

-------------------- Fuzzy Search --------------------------------
vim.keymap.set("n", "<C-f>", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes"))
end, { desc = "[/] Fuzzily search in current buffer]" })


local exec_table = {}
exec_table["py"] = "python3 "
exec_table["js" or "ts" or "jsx" or "tsx"] = "npm start"
exec_table["svelte"] = "yarn dev"
exec_table["cs"] = "dotnet run"


GetExecutioner = function(filename)
  local str = filename
  local temp = ""
  local result = ""
  for i = str:len(), 1, -1 do
    if str:sub(i,i) ~= "." then
      temp = temp..str:sub(i,i)
    else
      break
    end
  end

  for j = temp:len(), 1, -1 do
    result = result..temp:sub(j,j)
  end

  local cmd = exec_table[result]

  if(cmd == nil) then
    return {type="error", title="compiler error", message={'unknown filetype ".'..result..'"', "no interpreter or compiler was found for compiling this file"} }
  end

  if(result == "py") then
    return cmd..filename
  else
    return cmd
  end
end
