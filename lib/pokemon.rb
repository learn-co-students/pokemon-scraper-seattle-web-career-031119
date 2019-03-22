require_relative "../bin/environment.rb"
class Pokemon
  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  def initialize(name:, type:, id: nil, db:, hp: nil)
    @name = name
    @type = type
    @db = db
    @hp = hp
    @id = id
  end

  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type)
            VALUES (?, ?)"
    db.execute(sql, name, type)
  end

  def self.new_from_db(row, db)
    pokemon = self.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])
    pokemon
  end

  def self.find(id, db)
    sql =  <<-SQL
      SELECT * FROM pokemon
      WHERE id = ?
      LIMIT 1
    SQL

    db.execute(sql, id).map do |row|
      self.new_from_db(row, db)
    end.first
  end

  def alter_hp(hp, db)
    sql =  <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL

    @hp = hp
    db.execute(sql, hp, self.id)

  end
end
