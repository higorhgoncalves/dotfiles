return {
    filetypes = {
        "php",
        "blade",
        "php_only"
    },
    init_options = {
        licenceKey = "/home/administrador/intelephense/key.txt",
    },
    settings = {
        intelephense = {
            environment = {
                includePaths = {
                    -- Use Docker container paths if Intelephense runs inside container
                    "/home/administrador/docker-lw/html/classes",
                },
            },
            files = {
                maxSize = 5000000,
            },
            -- Add workspace settings if needed
            workspace = {
                -- Add other project roots if needed
                -- "/var/www/html/intranet",
                -- "/var/www/html/legisweb"
            },
        },
    },
}
