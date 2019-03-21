require "pry"
class Pokemon

  attr_accessor :type
  attr_reader :id, :name, :db, :hp

  def initialize(id:, name:, type:, db:, hp: 60)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def alter_hp(new_value, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL

    db.execute(sql, new_value, self.id)
    @hp = new_value
  end

  def self.new_from_row(row, db)
    Pokemon.new({id: row[0], name: row[1], type: row[2], hp: row[3], db: db})
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon
      (name, type) VALUES
      (?, ?);
    SQL

    db.execute(sql, name, type)
    id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
    Pokemon.new({id: id, name: name, type: type, db: db})
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?;
    SQL

    db.execute(sql, id).map do |row|
      self.new_from_row(row, db)
    end.first
  end

end
