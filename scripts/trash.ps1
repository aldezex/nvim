# Send files and directories to the Windows Recycle Bin.
#
# Windows has no `trash` binary, which is what nvim-tree expects by default.
# This stands in for one: nvim-tree appends the path as the last argument, so
# any script taking paths as positional arguments works.
#
# Wired up in lua/plugins/tree.lua as `trash.cmd`.

param(
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]]$Paths
)

$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName Microsoft.VisualBasic

try {
    foreach ($path in $Paths) {
        $full = (Resolve-Path -LiteralPath $path).ProviderPath

        if (Test-Path -LiteralPath $full -PathType Container) {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory(
                $full,
                [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs,
                [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin)
        }
        else {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
                $full,
                [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs,
                [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin)
        }
    }
}
catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}

exit 0
