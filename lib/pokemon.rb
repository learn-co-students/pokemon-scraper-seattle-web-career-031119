class Pokemon

  attr_accessor :name, :type, :id, :db, :hp

  def initialize(id: nil, name:, type:, hp: 60, db:)
    @name = name
    @type = type
    @id = id
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    db.execute(sql, id).collect {|row|
      Pokemon.new(id: row[0], name: row[1], type: row[2], hp: row[3], db: db)
    }.first
  end

  def alter_hp(hp, db)
    self.hp = hp
    sql = "UPDATE pokemon SET hp = ? WHERE id = ?"
    db.execute(sql, self.hp, self.id)
  end

end
