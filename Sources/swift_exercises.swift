// http://bulbapedia.bulbagarden.net/wiki/Type
enum Type {
    case bug
    case dark
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
}

// http://bulbapedia.bulbagarden.net/wiki/Damage_category
enum Category {
    case physical
    case special
    case status
}

// http://bulbapedia.bulbagarden.net/wiki/Nature
enum Nature {
    case hardy
    case lonely
    case brave
    case adamant
    case naughty
    case bold
    case docile
    case relaxed
    case impish
    case lax
    case timid
    case hasty
    case serious
    case jolly
    case naive
    case modest
    case mild
    case quiet
    case bashful
    case rash
    case calm
    case gentle
    case sassy
    case careful
    case quirky
}

// http://bulbapedia.bulbagarden.net/wiki/Weather
enum Weather {
    case clear_skies
    case harsh_sunlight (extremely: Bool)
    case rain (heavy : Bool)
    case sandstorm
    case hail (diamond_dust : Bool)
    case shadowy_aura
    case fog
    case mysterious_air_current
}

enum Terrain {
    case normal
    case electric
    case grassy
    case psychic
    case misty
}

// http://bulbapedia.bulbagarden.net/wiki/Move
struct Move : Hashable {
    let id          : Int
    let name        : String
    let description : String
    let category    : Category
    let type        : Type
    let power       : Int
    let accuracy    : Int
    let powerpoints : Int
    let priority    : Int

    var hashValue   : Int {
      return self.id
    }
}
func ==(lhs: Move, rhs: Move) -> Bool {
    return lhs.id == rhs.id
}




// http://bulbapedia.bulbagarden.net/wiki/Statistic
struct Stats {
    let hitpoints       : Int
    let attack          : Int
    let defense         : Int
    let special_attack  : Int
    let special_defense : Int
    let speed           : Int
}

struct Species : Hashable {
    let id          : Int
    let name        : String
    let evolutions  : Set<Species>
    let attacks     : Set<Move>
    let type        : (Type, Type?)
    let base_values : Stats
    var hashValue   : Int {
      return self.id
    }
}
func ==(lhs: Species, rhs: Species) -> Bool {
    return lhs.id == rhs.id
}

// TODO: create some species
// Do you use an enum, a map or constants/variables?
// http://bulbapedia.bulbagarden.net/wiki/List_of_Pokémon_by_National_Pokédex_number

// Dracaufeu
/*
let moveAirSlash = Move(id: 1, name: "Air Slash", description: "Air Slash deals damage and has a 30% chance of causing the target to flinch", category: Category.special, type: Type.flying, power: 75, accuracy: 95, powerpoints: 20, priority: 0)

let moveDragonClaw = Move(id: 2, name: "Dragon Claw", description: "Dragon Claw deals damage with no additional effect.", category: Category.physical, type: Type.dragon, power: 80, accuracy: 100, powerpoints: 15, priority: 0)

let moveEmber = Move(id: 3, name: "Ember", description: "Ember deals damage and has a 10% chance of burning the target.", category: Category.special, type: Type.fire, power: 40, accuracy: 100, powerpoints: 25, priority: 0)

let moveFlareBlitz = Move(id: 4, name: "Flare Blitz", description: "Flare Blitz deals damage and has a 10% chance of burning the target, but the user receives 1⁄3 of the damage it inflicted in recoil. In other words, if the attack does 90 HP damage to the opponent, the user will lose 30 HP.", category: Category.physical, type: Type.fire, power: 120, accuracy: 100, powerpoints: 15, priority: 0)

let moveGrowl = Move(id: 5, name: "Growl", description: "Growl lowers the target's Attack by one stage.", category: Category.status, type: Type.normal, power: 0, accuracy: 100, powerpoints: 40, priority: 0)

//let moveHeatWave = Move(id: 6, name: "Heat Wave", description: "Heat Wave deals damage and has a 10% chance of burning the target.", category: Category.special, type: Type.fire, power: 95, accuracy: 90, priority: 0)

let charizardStat = Stats(hitpoints: 0, attack: 0, defense: 0, special_attack: 3, special_defense: 0, speed: 0)

let charizard = Species(id: 006, name: "Charizard", evolutions: [], attacks: [moveAirSlash, moveDragonClaw, moveEmber, moveFlareBlitz, moveGrowl, moveHeatWave], type: (Type.fire, nil), base_values: charizardStat)
*/

// Pikachu
let pikachuStats = Stats(hitpoints: 35, attack: 55, defense: 30, special_attack: 50,special_defense: 40, speed: 90)

let thunderShockAttack = Move(id: 84,
                                     name: "Thunder Shock",
                                     description: "paralyze target",
                                     category: Category.special,
                                     type: Type.electric,
                                     power:40,
                                     accuracy:100,
                                     powerpoints:30,
                                     priority:0 ///////////// ???????????????,
                                   )


let pikachu = Species(id: 025,
                      name: "Pikachu",
                      evolutions: [raichu],
                      attacks: [thunderShockAttack],
                      type: (Type.electric, nil),
                      base_values: pikachuStats
              )
let raichuStats = Stats(hitpoints: 60, attack: 90, defense: 55, special_attack: 90,special_defense: 80, speed: 110)

let raichu = Species(id: 026,
                      name: "Raichu",
                      evolutions: [],
                      attacks: [thunderShockAttack],
                      type: (Type.electric, nil),
                      base_values: raichuStats
              )


/*func valeur_nature(pokemon: Pokemon, ) -> Double {
    if  {
        body
    }
}*/

struct Pokemon {
    let nickname          : String?
    let hitpoints         : Int // remaining hitpoints
    let size              : Int
    let weight            : Int
    let experience        : Int
    let level             : Int
    let nature            : Nature
    let species           : Species
    let moves             : [Move: Int] // Move -> remaining powerpoints
    let individual_values : Stats
    let effort_values     : Stats
    var effective_stats   : Stats { // effective_stats for Generations I and II)
                             // chercher comment faire pour la multiplication par Nature
                                  let hitpoints: Int = (((2*self.species.base_values.hitpoints + self.individual_values.hitpoints + (self.effort_values.hitpoints/4).round(.down))*self.level)/100).round(.down) + self.level + 10
                                  let attack: Int = (((2*self.species.base_values.attack + self.individual_values.attack + (self.effort_values.attack/4).round(.down))*self.level)/100).round(.down)// * valeur_nature(self)
                                  let defense: Int = (((2*self.species.base_values.defense + self.individual_values.defense + (self.effort_values.defense/4).round(.down))*self.level)/100).round(.down) // * Nature
                                  let special_attack: Int = (((2*self.species.base_values.special_attack + self.individual_values.special_attack + (self.effort_values.special_attack/4).round(.down))*self.level)/100).round(.down) // * Nature
                                  let special_defense: Int = (((2*self.species.base_values.special_defense + self.individual_values.special_defense + (self.effort_values.special_defense/4).round(.down))*self.level)/100).round(.down) // * Nature
                                  let speed: Int = (((2*self.species.base_values.speed + self.individual_values.speed + (self.effort_values.speed/4).round(.down))*self.level)/100).round(.down) // * Nature

                            }
    // TODO: implement the effective stats as a computed property:
    // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID259
    // var effective_stats   : Stats {
    // }
}

struct Trainer {
    let pokemons : [Pokemon]
}

struct Environment {
    let weather : Weather
    let terrain : Terrain
}

// http://bulbapedia.bulbagarden.net/wiki/Type/Type_chart
/*func typeModifier(attacking: Type, defending : Type) -> Double {
    // TODO: encode type/type chart

    // Tout d'abord, définissons la "matrice" qui contient l'indice que l'on doit renvoyer: Génération VI
    let Generation_VI_onward: [Type: [Type: Double]] = [
    .normal:   [1,1,1,1,1,0.5,1,0,0.5,1,1,1,1,1,1,1],
    .fighting: [1,2,1,0.5,0.5,1,2,0.5,0,2,1,1,1,1,0.5,2],
    .flying:   [2,0.5,1,2,1,1,1,0.5,2,1,0.5,1,1,2,0.5,1],
    .poison:   [1,1,1,1,1,1,0.5,0.5,0.5,1,0.5,0,1,1,2,1],
    .ground:   [1,1,1,2,1,1,0,2,1,2,0.5,1,2,2,1,0.5],
    .rock:     [1,1,1,1,1,1,0.5,2,1,0.5,1,2,1,0.5,2,1],
    .bug:      [1,1,2,1,1,1,1,0.5,0.5,0.5,1,1,1,0.5,0.5,0.5],
    .ghost:    [2,1,2,1,1,2,0.5,0,1,1,1,1,1,1,2,1],
    .steel:    [1,1,1,2,1,1,0.5,1,1,1,1,1,1,2,1,1],
    .fire:     [0.5,0.5,1,0.5,1,2,1,1,2,1,1,1,1,1,0.5,2],
    .water:    [2,0.5,0.5,2,1,1,2,0.5,1,1,1,1,1,1,2,2],
    .grass:    [1,1,2,0.5,0.5,1,1,1,0.5,1,1,1,1,0.5,0.5,2],
    .electric: [0.5,1,0.5,0.5,2,0.5,1,1,1,0.5,1,1,1,1,2,1],
    .psychic:  [1,1,1,1,1,2,0.5,0.5,1,1,0.5,1,1,1,2,1],
    .ice:      [1,1,1,1,0.5,1,1,1,1,0.5,1,1,0,1,1,1],
    .dragon:   [1,2,1,1,1,0.5,0.5,0.5,2,1,1,0.5,2,1,1,1],
    .dark:     [1,1,1,1,1,1,0.5,1,1,1,1,1,1,2,1,0],
    .fairy:    [0.5,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5],
               [1,2,1,0.5,1,1,1,1,0.5,0.5,1,1,1,1,1,2]]

    // Définissons une matrice avec les différents types de type Type: On doit écrire dans l'ordre que c'est écrit sur le tableau de Bulbapedia
    let matrices_types: [Type] = [Type.normal,
                                  Type.fighting,
                                  Type.flying,
                                  Type.poison,
                                  Type.ground,
                                  Type.rock,
                                  Type.bug,
                                  Type.ghost,
                                  Type.steel,
                                  Type.fire,
                                  Type.water,
                                  Type.grass,
                                  Type.electric,
                                  Type.psychic,
                                  Type.ice,
                                  Type.dragon,
                                  Type.dark,
                                  Type.fairy]


    // Retrouvons les indices pour renvoyer la bonne valeur avec index(of:)
    let attacking_type_indice: Int = matrices_types.index(of: attacking)!
    let defending_type_indice: Int = matrices_types.index(of: defending)!

    return Double(Generation_VI_onward[attacking_type_indice][defending_type_indice])!
  }

*/

/* COMMENTAIRE ORIGINE

func calcule_valeur_damage(environment: Environment, pokemon: Pokemon, move: Move, target: Pokemon) -> Int {
  let var1: Double = ((2*pokemon.level)/5) + 2;
  let var2: Double = pokemon.power

  let final_result: Int = var1*var2
}

// http://bulbapedia.bulbagarden.net/wiki/Damage
func damage(environment : Environment, pokemon: Pokemon, move: Move, target: Pokemon) -> Int {
    // TODO
      let damage_value = 0;
    if move.category == Category.status {
        return 0
    }
    else if move.category == Category.special {
        let damage_value = calcule_valeur(environment: Environment, pokemon: Pokemon, move: Move, target: Pokemon);

        return damage_value
    }
    else{
        // commentaire prochaine ligne + comment on fait quand special defense stat ou special attack
      //  let damage_value = ((((2*pokemon.level+10)*(pokemon.effective_stats.attack)*(pokemon.species.attacks.index(of: move).power))/(250*target.effective_stats.defense)) + 2) //* typeModifier(attacking: pokemon.species.type[0], defending : target.species.type[0]) // Utilisation du premier type mais a confirmer
        // pour la variable modifier, on utilise valeur par formeule donné ou de la fonction juste en haut


        return damage_value;
  }
}

struct attacks{


}

struct State {
      let Pokemon1: Pokemon;
      let Pokemon2: Pokemon;
      let environement: Environment;
      var all_attacks: [attacks];

    // TODO: describe a battle
}

func battle(trainers: inout [Trainer], behavior: (State, Trainer) -> Move) -> () {
    // TODO: simulate battle
}

*/
