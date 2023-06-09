local m = require('functions.keymap')

-- cmp
local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp', max_item_count = 20, priority = 10 },
        { name = 'luasnip', max_item_count = 20, priority = 10 },
        { name = 'buffer', max_item_count = 10, priority = 3 },
        { name = 'path', max_item_count = 10, priority = 3 },
    }
}

-- lsp
local nvim_lsp = require('lspconfig')

-- disable virtual text
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
    { update_in_insert = true, virtual_text = false })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = "single" })
-- show diagnostics in floating window
vim.o.updatetime = 250
vim.api.nvim_create_augroup('LspConfig', {clear = true})
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    callback = function() vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' }) end,
    group = 'LspConfig'
})

local function on_init(client)
    client.config.flags.debounce_text_change = 150
end

local client_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- clangd and lua are handled externally
for _, lsp in ipairs { 'neocmake', 'gopls', 'pyright', 'rust_analyzer', 'tsserver', 'zls', 'jdtls'} do
    nvim_lsp[lsp].setup {
        capabilities = client_capabilities,
        on_init = on_init
    }
end

nvim_lsp.lua_ls.setup {
    capabilities = client_capabilities,
    on_init = on_init,
    settings = {
        Lua = {
            diagnostic = {
                globals = { 'vim' }
            }
        }
    }
}

-- clangd
nvim_lsp.clangd.setup {
    cmd = {
        'clangd',
        '--header-insertion=never',
        '--all-scopes-completion',
        '--background-index',
        '--clang-tidy',
    },
    capabilities = client_capabilities,
    on_init = on_init
}

m.keys {
    { 'n', 'gd', vim.lsp.buf.definition },
    { 'n', '<leader>rs', vim.lsp.buf.signature_help },
    { 'n', '<leader>rr', vim.lsp.buf.references },
    { 'n', '<leader>ro', vim.lsp.buf.rename },
    { 'n', '<leader>rh', vim.lsp.buf.hover, { buffer = 0, noremap = true, silent = true }},
    { 'n', '<leader>re', vim.lsp.buf.code_action },
    { 'n', '<leader>rn', vim.diagnostic.goto_next },
    { 'n', '<leader>rp', vim.diagnostic.goto_prev },
    { 'n', '<leader>rd', vim.diagnostic.setqflist },
    { {'n', 'v'}, '<leader>rf', function() vim.lsp.buf.format { async = true } end },
}

