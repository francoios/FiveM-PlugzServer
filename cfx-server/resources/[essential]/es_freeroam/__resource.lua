resource_type 'gametype' { name = 'es_freeroam'}

description 'FiveM es_freeroam'

-- Manifest
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Requiring essentialmode
dependency 'essentialmode'

-- General
client_scripts {
  'client.lua',
  'events/smoke.lua',
  'player/map.lua',
  'player/scoreboard.lua',
  'stores/stripclub.lua',
}

server_scripts {
  'server.lua',
  'player/commands.lua',
}
