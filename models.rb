require 'bundler/setup'
Bundler.require

if development?
	ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

# class モデル < ActiveRecord::Base
    
# end