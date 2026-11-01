-- PHP Debugging with Xdebug
-- NOTE: PHP debugging is configured but vscode-php-debug has npm build issues.
-- You can debug PHP with Xdebug using alternative methods:
-- 1. Use VSCodium with PHP Debug extension
-- 2. Use browser + Xdebug helper extension
-- 3. Uncomment the code below and run: npm install -g vscode-php-debug

-- Uncomment this block when you want to enable PHP debugging:
--[[
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- PHP Debug Adapter
      {
        "xdebug/vscode-php-debug",
        build = "npm install && npm run build",
      },
    },
    opts = function()
      local dap = require("dap")

      -- PHP Xdebug adapter
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/lazy/vscode-php-debug/out/phpDebug.js" },
      }

      -- PHP Xdebug configurations
      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (Valet - Local)",
          port = 9003,
          pathMappings = {
            ["/Users/il1v3y/.valet/Sites"] = vim.fn.getcwd(),
            ["/home/il1v3y/.valet/Sites"] = vim.fn.getcwd(),
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Listen for Xdebug (Podman Container)",
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = vim.fn.getcwd(),
          },
        },
        {
          type = "php",
          request = "launch",
          name = "Launch currently open script",
          program = "${file}",
          cwd = "${fileDirname}",
          port = 9003,
        },
      }
    end,
  },
}
--]]

-- Temporary workaround: PHP debugging disabled
-- PHPActor refactoring still works perfectly!
return {}
