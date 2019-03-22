require "pry"

class Pokemon
  attr_accessor :name, :type, :db, :id

  def initialize(id:, name:, type:, db:, hp:nil)
    @id = nil
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon
      (name, type)
      VALUES (?, ?);
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql=<<-SQL
      SELECT *
      FROM pokemon
      WHERE id == ?;
    SQL
    row = db.execute(sql, id)[0]
    new_poke = Pokemon.new(id:row[0], name:row[1], type:row[2], db:db, hp:60)
    new_poke.id=id
    new_poke
  end

end
