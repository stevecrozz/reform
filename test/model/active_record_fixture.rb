ACTIVE_RECORD_DB = 'test.db'

if File.exists?(ACTIVE_RECORD_DB)
  File.unlink(ACTIVE_RECORD_DB)
end

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = Logger::Severity::INFO
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ACTIVE_RECORD_DB
)

class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :groups
  end
end

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.references :group
    end
  end

  def self.down
    drop_table :users
  end
end

CreateUsers.up
CreateGroups.up

class Group < ActiveRecord::Base
  has_many :users

  def to_s
    self.name
  end
end

class User < ActiveRecord::Base
  belongs_to :group
end

Group.create(:name => "admin")
Group.create(:name => "publisher")
Group.create(:name => "user")

