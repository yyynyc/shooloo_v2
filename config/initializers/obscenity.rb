Obscenity.configure do |config|
  config.blacklist   = "config/badwords.yml"
  config.whitelist   = ["safe", "word"]
  config.replacement = :stars
end