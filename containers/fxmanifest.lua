fx_version 'cerulean'
games { 'gta5' }

author 'Droopies'
version '1.0'

client_scripts {
'client/*.lua'
}

server_scripts {
"@mysql-async/lib/MySQL.lua",,
'config.lua',
'server/*.lua',
}
