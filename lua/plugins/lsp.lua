return {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    event = { "VeryLazy" },
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits"
                }
            }
        }

        local lspconfig = require "lspconfig"

        lspconfig.lua_ls.setup {
            filetypes = { "lua" },
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT"
                    },
                    completion = {
                        callSnippet = "Replace"
                    },
                    diagnostics = {
                        globals = { "vim" }
                    },
                    format = {
                        defaultConfig = {}
                    },
                    hint = {
                        enable = true
                    }
                }
            }
        }

        lspconfig.ts_ls.setup {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx"
            },
            init_options = {
                hostInfo = "neovim"
            },
            single_file_support = true,
            settings = {
                completions = {
                    completeFunctionCalls = true
                }
            }
        }
    end
}
