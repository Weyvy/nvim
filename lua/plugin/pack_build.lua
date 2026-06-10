local M = {}

local builds = {}
local did_setup = false

function M.run_build(name, cmd, cwd)
	local result = vim.system(cmd, {
		cwd = cwd,
		text = true,
	}):wait()

	if result.code ~= 0 then
		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local output = stderr ~= "" and stderr or stdout

		if output == "" then
			output = "No output from build command."
		end

		vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
	end
end

function M.register(name, build)
	builds[name] = build
end

function M.setup()
	if did_setup then
		return
	end

	did_setup = true

	vim.api.nvim_create_autocmd("PackChanged", {
		group = vim.api.nvim_create_augroup("user-pack-build", { clear = true }),
		callback = function(ev)
			local data = ev.data or {}
			local kind = data.kind

			if kind ~= "install" and kind ~= "update" then
				return
			end

			local spec = data.spec or {}
			local name = spec.name
			local build = builds[name]

			if build == nil then
				return
			end

			if type(build) == "function" then
				build(data, M.run_build)
				return
			end

			if type(build) == "table" then
				M.run_build(name, build, data.path)
			end
		end,
	})
end

return M