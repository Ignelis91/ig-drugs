fx_version 'cerulean'
game 'gta5'

description 'Esx'
version '1.0'


client_scripts {
    'client/peds.lua',
    '@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/amfa.lua',
	'client/main.lua',
	'target.lua',
	'client/weed.lua',
	'client/coke.lua',
	'client/moneywash.lua',
	'client/heroin.lua',
}


server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua',
	'server/coke.lua',
	'server/weed.lua',
	'server/heroin.lua',
	'server/sv-amfa.lua',
	'server/moneywash.lua',
}

dependencies {
	'es_extended',
    'rprogress'
}
