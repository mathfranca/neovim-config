return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				local status_ok, jdtls = pcall(require, "jdtls")
				if not status_ok then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()

				local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/"
				local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test/"
				local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"

				local bundles = {
					vim.fn.glob(java_debug_path .. "extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
				}
				vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "extension/server/*.jar", 1), "\n"))

				WORKSPACE_PATH = vim.fn.stdpath("data") .. "/workspace/"
				if vim.fn.has("mac") == 1 then
					OS_NAME = "mac"
				elseif vim.fn.has("unix") == 1 then
					OS_NAME = "linux"
				elseif vim.fn.has("win32") == 1 then
					OS_NAME = "win"
				else
					vim.notify("Unsupported OS", vim.log.levels.WARN, { title = "Jdtls" })
				end

				local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

				local workspace_dir = WORKSPACE_PATH .. project_name

				local config = {
					cmd = {
						-- 💀
						"/home/meyng/.sdkman/candidates/java/17.0.9-zulu/bin/java", -- or '/path/to/java17_or_newer/bin/java'
						-- depends on if `java` is in your $PATH env variable and if it points to the right version.

						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-javaagent:" .. jdtls_path .. "/lombok.jar",
						"-Xms1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						-- 💀
						"-jar",
						vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
						-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
						-- Must point to the                                                     Change this to
						-- eclipse.jdt.ls installation                                           the actual version
						-- 💀
						"-configuration",
						jdtls_path .. "config_" .. OS_NAME,
						-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
						-- Must point to the                      Change to one of `linux`, `win` or `mac`
						-- eclipse.jdt.ls installation            Depending on your system.

						"-data",
						workspace_dir,
					},
					-- 💀
					-- This is the default if not provided, you can remove it. Or adjust as needed.
					-- One dedicated LSP server & client will be started per unique root_dir
					root_dir = require("jdtls.setup").find_root(root_markers),
					init_options = {
						bundles = bundles,
					},
					settings = {
						eclipse = {
							downloadSources = true,
						},
						maven = {
							downloadSources = true,
						},
						implementationsCodeLens = {
							enabled = true,
						},
						referencesCodeLens = {
							enabled = true,
						},
						references = {
							includeDecompiledSources = true,
						},

						signatureHelp = { enabled = true },
						extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
					},
					flags = {
						allow_incremental_sync = true,
					},
				}

				local keymap = vim.keymap.set
				--
				keymap(
					"n",
					"<leader>jo",
					":lua require'jdtls'.organize_imports()<cr>",
					{ silent = true, buffer = bufnr, desc = "Organize imports" }
				)
				keymap(
					"n",
					"<leader>jxv",
					":lua require'jdtls'.extract_variable()<cr>",
					{ silent = true, buffer = bufnr, desc = "Extract variable" }
				)
				keymap(
					"v",
					"<leader>jxv",
					":lua require'jdtls'.extract_variable(true)<cr>",
					{ silent = true, buffer = bufnr, desc = "Extract variable" }
				)
				-- keymap("v", "crv", "<Esc>:lua require'jdtls'.extract_variable(true)<cr>", { silent = true, buffer = bufnr })
				keymap(
					"n",
					"<leader>jxc",
					":lua require'jdtls'.extract_constant()<cr>",
					{ silent = true, buffer = bufnr, desc = "Extract constant" }
				)
				keymap(
					"v",
					"<leader>jxc",
					"<Esc>:lua require'jdtls'.extract_constant(true)<cr>",
					{ silent = true, buffer = bufnr, desc = "Extract constant" }
				)
				keymap(
					"v",
					"<leader>jxm",
					"<Esc>:lua require'jdtls'.extract_method(true)<cr>",
					{ silent = true, buffer = bufnr, desc = "Extract method" }
				)
				--
				vim.cmd([[
				command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
				command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
				command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
				command! -buffer JdtJol lua require('jdtls').jol()
				command! -buffer JdtBytecode lua require('jdtls').javap()
				command! -buffer JdtJshell lua require('jdtls').jshell()
				command! -buffer JavaTestCurrentClass lua require('jdtls').test_class()
				command! -buffer JavaTestNearestMethod lua require('jdtls').test_nearest_method()
				]])

				-- This starts a new client & server,
				-- or attaches to an existing client & server depending on the `root_dir`.
				jdtls.start_or_attach(config)
			end,
		})
	end,
}
