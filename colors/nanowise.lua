local M = {}
local hl = vim.api.nvim_set_hl

local colors = {
    bg = "#2A324B",
    bg_dark = "#242b40", 
    bg_highlight = "#303956",
    bg_selection = "#3A446B",
    fg = "#F3F4F5",
    fg_dark = "#bebebe",
    fg_gutter = "#9194A2",
    border = "#47506B",
    keyword = "#FF577F",
    func = "#FFCC00",
    string = "#ffd000",
    constant = "#B3FF63",
    number = "#FF5C57",
    comment = "#7D808C",
    type = "#B3FF63",
    variable = "#f3f4f5",
    parameter = "#5DD9FF",
    operator = "#ADB1C2",
    error = "#FF5C56",
    warning = "#FFCC00",
    info = "#5DD9FF",
    hint = "#969696",
    add = "#B3FF63",
    delete = "#FF5C57",
    change = "#00A39F",
}

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.g.colors_name = 'nanowise'

local editor = {
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg_dark },
    ColorColumn = { bg = colors.bg_highlight },
    Cursor = { fg = colors.bg, bg = colors.fg },
    CursorLine = { bg = colors.bg_highlight },
    CursorColumn = { bg = colors.bg_highlight },
    LineNr = { fg = colors.fg_gutter },
    CursorLineNr = { fg = colors.fg },
    DiffAdd = { fg = colors.add },
    DiffChange = { fg = colors.change },
    DiffDelete = { fg = colors.delete },
    DiffText = { fg = colors.fg },
    EndOfBuffer = { fg = colors.fg_gutter },
    VertSplit = { fg = colors.border },
    Folded = { fg = colors.fg_dark, bg = colors.bg_highlight },
    FoldColumn = { fg = colors.fg_gutter },
    SignColumn = { fg = colors.fg_gutter },
    IncSearch = { fg = colors.bg, bg = colors.warning },
    Search = { fg = colors.bg, bg = colors.warning },
    MatchParen = { fg = colors.warning, bold = true },
    NonText = { fg = colors.fg_gutter },
    Pmenu = { fg = colors.fg, bg = colors.bg_dark },
    PmenuSel = { fg = colors.bg, bg = colors.warning },
    Question = { fg = colors.info },
    QuickFixLine = { bg = colors.bg_highlight },
    StatusLine = { fg = colors.fg, bg = colors.bg_dark },
    StatusLineNC = { fg = colors.fg_gutter, bg = colors.bg_dark },
    TabLine = { fg = colors.fg_gutter, bg = colors.bg_dark },
    TabLineFill = { bg = colors.bg_dark },
    TabLineSel = { fg = colors.fg, bg = colors.bg },
    Title = { fg = colors.func, bold = true },
    Visual = { bg = colors.bg_selection },
    VisualNOS = { bg = colors.bg_selection },
    WarningMsg = { fg = colors.warning },
    Whitespace = { fg = colors.fg_gutter },
}

local syntax = {
    Comment = { fg = colors.comment, italic = true },
    Constant = { fg = colors.constant },
    String = { fg = colors.string },
    Character = { fg = colors.string },
    Number = { fg = colors.number },
    Boolean = { fg = colors.parameter },
    Float = { fg = colors.number },
    Identifier = { fg = colors.variable },
    Function = { fg = colors.func, bold = true },
    Statement = { fg = colors.keyword, italic = true },
    Conditional = { fg = colors.keyword, italic = true },
    Repeat = { fg = colors.keyword, italic = true },
    Label = { fg = colors.keyword },
    Operator = { fg = colors.operator },
    Keyword = { fg = colors.keyword, italic = true, bold = true },
    Exception = { fg = colors.keyword },
    PreProc = { fg = colors.keyword },
    Include = { fg = colors.keyword },
    Define = { fg = colors.keyword },
    Macro = { fg = colors.keyword },
    PreCondit = { fg = colors.keyword },
    Type = { fg = colors.type, bold = true },
    StorageClass = { fg = colors.type },
    Structure = { fg = colors.type },
    Typedef = { fg = colors.type },
    Special = { fg = colors.warning },
    SpecialChar = { fg = colors.string },
    Tag = { fg = colors.warning },
    Delimiter = { fg = colors.operator },
    SpecialComment = { fg = colors.comment, italic = true },
    Debug = { fg = colors.warning },
    Underlined = { underline = true },
    Error = { fg = colors.error },
    Todo = { fg = colors.warning, bold = true },
}

local lsp = {
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.warning },
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.hint },
}

for group, opts in pairs(editor) do
    hl(0, group, opts)
end
for group, opts in pairs(syntax) do
    hl(0, group, opts)
end
for group, opts in pairs(lsp) do
    hl(0, group, opts)
end
