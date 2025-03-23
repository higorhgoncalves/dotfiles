-- Este arquivo importa configurações extras do usuário
return {
    -- Importando a config do colorscheme
    require("config.colorscheme")[1],
    require("config.keymaps").setup(),

    -- Você pode adicionar outros plugins diretamente aqui também
    -- { "plugin/exemplo" },
}
