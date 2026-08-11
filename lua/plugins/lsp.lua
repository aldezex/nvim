-- nvim-lspconfig only contributes the `lsp/*.lua` files holding each server's
-- defaults (cmd, root markers, filetypes). Our own configuration goes through
-- the native 0.11+ API: `vim.lsp.config` registers it, `vim.lsp.enable` turns
-- it on. Watch out for the easy mistake: `vim.lsp.enable(name, table)`
-- configures nothing — the second argument is a boolean and the table is
-- silently discarded.
return {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()

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

        vim.lsp.config('lua_ls', {
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
        })

        vim.lsp.config('ts_ls', {
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
        })

        vim.lsp.config('gopls', {
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
        })

        vim.lsp.enable({ 'lua_ls', 'ts_ls', 'gopls', 'biome' })

        -- This is what the `opts = { inlay_hints = … }` that lspconfig never
        -- read was trying to say: the hints configured for gopls and lua_ls
        -- above are not rendered unless something enables them per buffer.
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client:supports_method('textDocument/inlayHint') then
                    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                end
            end,
        })
    end
}
