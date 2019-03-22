require_relative "environment"

Scraper.new(@db).scrape

all_pokemon = @db.execute("SELECT * FROM pokemon;")

@sql_runner.execute_create_hp_column
pikachu = Pokemon.new(id: 1, name: "Pikachu", type: "electric", db: @db)
# magikarp = Pokemon.save('Magikarp', 'water', @db)
pikachu.alter_hp(59, @db)

binding.pry
#0
