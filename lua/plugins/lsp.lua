return {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    event = { "VeryLazy" },
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local lspconfig = require('lspconfig')

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

        lspconfig.lua_ls.setup {
            capabilities = capabilities,
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
            capabilities = capabilities,
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

        lspconfig.gopls.setup {
            cmd = { "gopls", "serve" },
            capabilities = capabilities,
            settings = {
                gopls = {
                    gofumpt = true,
                    codelenses = {
                        gc_details = false,
                        generate = true,
                        regenerate_cgo = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    analyses = {
                        -- fieldalignment = true,
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    usePlaceholders = true,
                    completeUnimported = true,
                    staticcheck = true,
                    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    semanticTokens = true,
                },
            },
        }

        lspconfig.biome.setup {}
    end
}
