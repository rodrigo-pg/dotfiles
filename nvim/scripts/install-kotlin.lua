local registry = require("mason-registry")
local finished, success = false, false
registry.refresh(function(ok)
    if not ok then
        print("Failed to refresh the Mason registry")
        finished = true
        return
    end
    local pkg = registry.get_package("kotlin-lsp")
    if pkg:is_installed() then
        success, finished = true, true
        return
    end
    pkg:once("install:success", function()
        success, finished = true, true
        print("Kotlin LSP installed")
    end)
    pkg:once("install:failed", function()
        finished = true
        print("Failed to install Kotlin LSP; see mason.log")
    end)
    -- The direct CDN URL returns 404; the official domain provides a signed redirect.
    local function fix_urls(tbl)
        for k, v in pairs(tbl) do
            if type(v) == "table" then
                fix_urls(v)
            elseif type(v) == "string" then
                tbl[k] = v:gsub("https://download%-cdn%.jetbrains%.com/", "https://download.jetbrains.com/")
            end
        end
    end
    fix_urls(pkg.spec)
    pkg:install()
end)
if not vim.wait(600000, function() return finished end, 200) then
    print("Installation timed out")
end
vim.cmd(success and "qa!" or "cquit 1")
