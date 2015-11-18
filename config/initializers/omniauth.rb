Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, ENV['Z5te4Esq7QoleXt4vAcrDmezY'], 
    ENV['okPnsy7m9W8S4cTzR92M8WmcVensBxGR2CVC1RyLOvTXzJVV2a']
end