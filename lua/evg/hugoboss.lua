local twt = {}

function twt.setup(opts)
    twt.opts = opts
end

local function get_template()
    local now = os.date('date: "%Y-%m-%dT%H:%M:%S"')
    local lines = {'---', now, '---', ''}

    return lines
end

local function get_filename(fname)
    if fname == "" or fname == nil then
        return os.date('%Y-%m-%d-%H-%M-%S.md')
    end

    return fname
end

function twt.twt(fname)
    vim.cmd("e " .. twt.opts.timeline_dir .. get_filename(fname))

    local curr_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(curr_buf, 0, 0, false, get_template())
    vim.cmd('startinsert')
end

vim.api.nvim_create_user_command('T',
    function(args)
        twt.twt(args.fargs[1])
    end,
    {
        nargs = '*'
    })

return twt
