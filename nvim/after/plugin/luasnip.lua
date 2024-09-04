local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()  -- Carrega snippets do friendly-snippets

-- Carregar snippets específicos para tipos de arquivos
luasnip.filetype_extend("javascript", {"html"})
luasnip.filetype_extend("typescript", {"html"})
luasnip.filetype_extend("javascriptreact", {"html"})
luasnip.filetype_extend("typescriptreact", {"html"})

