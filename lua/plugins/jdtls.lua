return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	config = function()
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = "/home/meyng/ac-digital/projetos/workspace/" .. project_name
		local lombok_path = "/home/meyng/.local/share/java/lombok/lombok.jar"
		local path_to_mason_packages = "/home/meyng/.local/share/nvim/mason/packages"
		local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
		local path_to_jtest = path_to_mason_packages .. "/java-test"
		local path_to_jar = "/home/meyng/.jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"


		local bundles = {
			vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug*.jar", true),
		}

		vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

		local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
		extendedClientCapabilities.resolveAdditionalTextEditsSupport = true


		local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
		extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

		local config = {
			-- The command that starts the language server
			-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
			cmd = {

				-- 💀
				'java', -- or '/path/to/java21_or_newer/bin/java'
				-- depends on if `java` is in your $PATH env variable and if it points to the right version.

				'-Declipse.application=org.eclipse.jdt.ls.core.id1',
				'-Dosgi.bundles.defaultStartLevel=4',
				'-Declipse.product=org.eclipse.jdt.ls.core.product',
				'-Dlog.protocol=true',
				'-Dlog.level=ALL',
				'-javaagent:' .. lombok_path,
				'-Xmx1g',
				'--add-modules=ALL-SYSTEM',
				'--add-opens', 'java.base/java.util=ALL-UNNAMED',
				'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

				-- 💀
				-- '-jar', '/home/meyng/.jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
				'-jar', path_to_jar,
				-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
				-- Must point to the                                                     Change this to
				-- eclipse.jdt.ls installation                                           the actual version


				-- 💀
				'-configuration', '/home/meyng/.jdtls/config_linux',
				-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
				-- Must point to the                      Change to one of `linux`, `win` or `mac`
				-- eclipse.jdt.ls installation            Depending on your system.


				-- 💀
				-- See `data directory configuration` section in the README
				'-data', workspace_dir,
			},

			-- 💀
			-- This is the default if not provided, you can remove it. Or adjust as needed.
			-- One dedicated LSP server & client will be started per unique root_dir
			--
			-- vim.fs.root requires Neovim 0.10.
			-- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
			root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),

			-- Here you can configure eclipse.jdt.ls specific settings
			-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
			-- for a list of options
			settings = {
				java = {
					references = {
						includeDecompiledSources = true,
					},
					eclipse = {
						downloadSources = true,
					},
					maven = {
						downloadSources = true,
					},
					signatureHelp = { enabled = true },
					configuration = {
						runtimes = {
							{
								name = "JavaSE-11",
								path = "/home/meyng/.local/share/java/zulu11.78.15-ca-fx-jdk11.0.26-linux_x64/",
							},
							{
								name = "JavaSE-21",
								path = "/home/meyng/.local/share/java/jdk-21.0.2",
							},
							{
								name = "JavaSE-8",
								path = "/home/meyng/.local/share/java/zulu8.84.0.15-ca-fx-jdk8.0.442-linux_x64/",
							},
							-- {
							-- 	name = "JavaSE-21",
							-- 	path = "/home/meyng/.sdkman/candidates/java/21.0.2-open/",
							-- },
							-- {
							-- 	name = "JavaSE-8",
							-- 	path = "/home/meyng/.sdkman/candidates/java/8.0.442.fx-zulu",
							-- },
						},
					},
				},
			},

			-- Language server `initializationOptions`
			-- You need to extend the `bundles` with paths to jar files
			-- if you want to use additional eclipse.jdt.ls plugins.
			--
			-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
			--
			-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
			init_options = {
				bundles = bundles,
			},
		}

		-- LSP settings for Java.
		local on_attach = function(_, bufnr)
			local jdtls = require('jdtls')
			jdtls.setup_dap({ hotcodereplace = "auto" })
			jdtls_dap.setup_dap_main_class_configs()
			jdtls_setup.add_commands()
			print("I've setup")

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })

			require("lsp_signature").on_attach({
				bind = true,
				padding = "",
				handler_opts = {
					border = "rounded",
				},
				hint_prefix = "󱄑 ",
			}, bufnr)
			vim.cmd [[
    augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'jdtls.jdtls_setup'.setup()
    augroup end
    ]]
			print("Ive created commands")
		end

		config.on_attach = on_attach
		config.capabilities = capabilities
		config.on_init = function(client, _)
			client.notify('workspace/didChangeConfiguration', { settings = config.settings })
		end

		local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
		extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
		-- This starts a new client & server,
		-- or attaches to an existing client & server depending on the `root_dir`.
		require("jdtls").start_or_attach(config)
	end,
}
