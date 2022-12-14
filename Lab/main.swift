// Spaceship Main Class
class Spaceship {
  var name: String
  var health: Int
  var position: Int = 10 // Default value

  // Initializer Overloading, possible if have a default value
  init(name: String, health: Int, position: Int) {
    self.name = name
    self.health = health
    self.position = position
  }

  init(name: String, health: Int) {
    self.name = name
    self.health = health
  }

  func moveLeft() {
    position -= 1
  }

  func moveRight() {
    position += 1
  }

  func wasHit() {
    health -= 5
    if health <= 0 {
      print("Sorry, your ship has exploded. Play again?")
    }
  }
}

// Fighter Sub Class
class Fighter: Spaceship {
  var weapon: String
  var remainingFirePower: Int

  init(name: String, health: Int, position: Int, weapon: String, remainingFirePower: Int) {
    self.weapon = weapon
    self.remainingFirePower = remainingFirePower
    // Super INIT need to be at last to allow weapon and firepower to be instanced
    super.init(name: name, health: health, position: position)
  }

  func fire() {
    if remainingFirePower > 0 {
      remainingFirePower -= 1
    } else {
      print("You ran out of ammo.")
    }
  }
}

// Shielded Sub Class
class shieldedShip: Fighter {
  var shieldStrength = 25

  init(name: String, health: Int, position: Int, weapon: String, remainingFirePower: Int, shieldStrength: Int) {
    self.shieldStrength = shieldStrength
    super.init(name: name, health: health, position: position, weapon: weapon, remainingFirePower: remainingFirePower)
  }

  // Override wasHit function
  override func wasHit() {
    if shieldStrength > 0 {
      shieldStrength -= 5
    } else {
      super.wasHit() // Reuse the initial function
      print("You are taking hull damage.")
    }
  }
}

// Normal Straightforward Code
/*
/*
New Spaceship
*/
let falcon = Spaceship()
falcon.name = "Falcon"

// Move Left
falcon.moveLeft()
// print("Left by \(falcon.position)")
falcon.moveLeft()
// print("Left by \(falcon.position)")
falcon.moveRight()
// print("Right by \(falcon.position)")

// Hit
falcon.wasHit()
// print("Your health now is \(falcon.health)")

/*
New Figher-class Spaceship
*/
let destroyer = Fighter()
destroyer.name = "X-Wing"

// print("Your Fighter-class spaceship: \(destroyer.name)")

destroyer.weapon = "Laser"
destroyer.remainingFirePower = 10

// print("You have a new weapon: \(destroyer.weapon). Remaining Ammo: \(destroyer.remainingFirePower)")

destroyer.fire()
// print("Remaining Ammo: \(destroyer.remainingFirePower)")

/*
New Shielded-class Spaceship
*/
let defender = shieldedShip()
defender.name = "Defender"
defender.weapon = "Repulser"

defender.moveRight()
// print("You are in position to defend. Right by \(defender.position).")

defender.fire()
// print("Remaining Ammo: \(defender.remainingFirePower)")

defender.wasHit()
defender.wasHit()
defender.wasHit()
// print("Remaining Health: \(defender.health)")

defender.wasHit()
defender.wasHit()
defender.wasHit()
// print("Remaining Shield: \(defender.shieldStrength)")
// print("Remaining Health: \(defender.health)")
*/

// Initializer Code
let falcon = Spaceship(name: "Falcon", health: 100, position: 0)
let falconTitan = Spaceship(name: "Falcon Titan", health: 500, position: 5)

let xWing = Fighter(name: "X-Wing", health: 250, position: -5, weapon: "Burst Laser", remainingFirePower: 50)

let enforcer = shieldedShip(name: "Enforcer", health: 1000, position: 15, weapon: "Ion Cannon", remainingFirePower: 25, shieldStrength: 100)
