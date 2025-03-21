local jdtls = require("jdtls")
local jdtls_dap = require("jdtls.dap")
local jdtls_setup = require("jdtls.setup")
local home = os.getenv("HOME")

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- 💀
local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

local path_to_jdtls = "/home/meyng/.jdtls"
local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
local path_to_jtest = path_to_mason_packages .. "/java-test"

local path_to_config = path_to_jdtls .. "/config_linux"
local lombok_path = "/home/meyng/.local/share/java/lombok/lombok.jar"

-- 💀
local path_to_jar = "/home/meyng/.jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^

local bundles = {
	vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

-- LSP settings for Java.
local capabilities = {
	workspace = {
		configuration = true
	},
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true
			}
		}
	}
}

local config = {
	flags = {
		allow_incremental_sync = true,
	},
}


config.cmd = {
	--
	-- 				-- 💀
	"java", -- or '/path/to/java17_or_newer/bin/java'
	-- depends on if `java` is in your $PATH env variable and if it points to the right version.

	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ERROR",
	"-Xmx1g",
	"-javaagent:" .. lombok_path,
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",

	-- 💀
	"-jar",
	path_to_jar,
	-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
	-- Must point to the                                                     Change this to
	-- eclipse.jdt.ls installation                                           the actual version

	-- 💀
	"-configuration",
	path_to_config,
	-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
	-- Must point to the                      Change to one of `linux`, `win` or `mac`
	-- eclipse.jdt.ls installation            Depending on your system.

	-- 💀
	-- See `data directory configuration` section in the README
	"-data",
	workspace_dir,
}

config.settings = {
	java = {
		references = {
			includeDecompiledSources = true,
		},
		format = {
			enabled = false,
			settings = {
				url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
				profile = "GoogleStyle",
			},
		},
		eclipse = {
			downloadSources = true,
		},
		maven = {
			downloadSources = true,
		},
		signatureHelp = { enabled = true },
		contentProvider = { preferred = "fernflower" },
		-- eclipse = {
		-- 	downloadSources = true,
		-- },
		-- implementationsCodeLens = {
		-- 	enabled = true,
		-- },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			filteredTypes = {
				"com.sun.*",
				"io.micrometer.shaded.*",
				"java.awt.*",
				"jdk.*",
				"sun.*",
			},
			importOrder = {
				"java",
				"javax",
				"com",
				"org",
			},
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				-- flags = {
				-- 	allow_incremental_sync = true,
				-- },
			},
			useBlocks = true,
		},
		configuration = {
			runtimes = {
				{
					name = "JavaSE-17",
					path = "/usr/lib/jvm/java-17-openjdk-amd64/"
				},
				{
					name = "JavaSE-11",
					path = "/usr/lib/jvm/java-11-openjdk-amd64"
				},
				{
					name = "JavaSE-21",
					path = "/usr/lib/jvm/java-21-openjdk-amd64"
				},
			}
		},
		-- project = {
		-- 	referencedLibraries = {
		-- 		"**/lib/*.jar",
		-- 	},
		-- },
	},
}


config.capabilities = capabilities
config.on_init = function(client, _)
	client.notify('workspace/didChangeConfiguration', { settings = config.settings })
end

local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

config.init_options = {
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}

config.handlers = {
	['language/status'] = function()
	end
}

-- Start Server
require('jdtls').start_or_attach(config)


vim.keymap.set("n", "<localleader>tm", "<cmd>lua require'jdtls'.test_nearest_method()<CR>",
	{ silent = true, desc = "Java: test nearest method" })
vim.keymap.set("n", "<localleader>tc", "<cmd>lua require'jdtls'.test_class()<CR>",
	{ silent = true, desc = "Java: test class" })
vim.keymap.set("n", "<localleader>oi", "<cmd>lua require'jdtls'.organize_imports()<CR>",
	{ silent = true, desc = "Java: organize imports" })
vim.keymap.set("n", "<localleader>ee", "<cmd>lua require('jdtls').extract_variable()<CR>",
	{ silent = true, desc = "Java: extract variable" })
vim.keymap.set("n", "<localleader>er", "<cmd>lua require('jdtls').extract_constant()<CR>",
	{ silent = true, desc = "Java: extract constant" })
vim.keymap.set("n", "<localleader>ef", "<cmd>lua require('jdtls').extract_method(true)<CR>",
	{ silent = true, desc = "Java: extract method" })
