require "./config/config.cr"
require "sam"
require "./db/migrations/*"

load_dependencies "jennifer"

Sam.help
