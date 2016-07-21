/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// ----------------------------------------------------------------------------
// Playground that includes Witches.
//
// These magical beings may be created and may cast spells on each other
// & their familiars (i.e. cats, bats, toads).
// ----------------------------------------------------------------------------

// All objects in this tutorial need an avatar, to make things exciting.

protocol MagicalTutorialObject {
  var avatar: String { get }
}

enum MagicWords: String {
  case Abracadbra = "abracadabra"
  case Alakazam = "alakazam"
  case HocusPocus = "hocus pocus"
  case PrestoChango = "presto chango"
}

struct Spell: MagicalTutorialObject {
  
  var magicWords: MagicWords = .Abracadbra
  var avatar = "💫"
  
  // If words are considered magical, we can create a spell
  init?(words: String) {
    guard let incantation = MagicWords(rawValue: words) else {
      return nil
    }
    self.magicWords = incantation
  }
  
  init?(magicWords: MagicWords) {
    self.magicWords = magicWords
  }
}


// ----------------------------------------------------------------------------
// Example Two - Avoiding Errors with Custom Handling - Pyramids of Doom
// ----------------------------------------------------------------------------

// Familiars

protocol Familiar: MagicalTutorialObject {
  var noise: String { get }
  var name: String? { get set }
  init()
  init(name: String?)
}

extension Familiar {
  init(name: String?) {
    self.init()
    self.name = name
  }
  func speak() {
    print(avatar, "* \(noise)s *")
  }
}


struct Cat: Familiar {
  var name: String?
  var noise  = "purr"
  var avatar = "🐱"
}

struct Bat: Familiar {
  var name: String?
  var noise = "screech"
  var avatar = "[bat]" // Sadly there is no bat avatar
  func speak() {
    print(avatar, "* \(noise)es *") // Different verb conjugation suffix than the protocol implementation
  }
}

struct Toad: Familiar {
  var name: String?
  var noise  = "croak"
  var avatar = "🐸"
}

// Magical Things

struct Hat {
  enum HatSize {
    case Small
    case Medium
    case Large
  }
  
  enum HatColor {
    case Black
  }
  
  var color: HatColor = .Black
  var size: HatSize = .Medium
  var isMagical = true
}


protocol MagicalBeing: MagicalTutorialObject {
  var name: String? { get set }
  var familiar: Familiar? { get set}
  var spells: [Spell] { get set }
  
  func turnFamiliarIntoToad() throws -> Toad
}

enum ChangoSpellError: ErrorType {
    case HatMissingOrNotMagical
    case NoFamiliar
    case FamiliarAlreadyAToad
    case SpellFailed(reason: String)
    case SpellNotKnownToWitch
}

struct Witch: MagicalBeing {
  var avatar = "👩🏻"
  var name: String?
  var familiar: Familiar?
  var spells: [Spell] = []
  var hat: Hat?
  
  init(name: String?, familiar: Familiar?) {
    self.name = name
    self.familiar = familiar
    
    if let s = Spell(magicWords: .PrestoChango) {
      self.spells = [s]
    }
  }
  
  init(name: String?, familiar: Familiar?, hat: Hat?) {
    self.init(name: name, familiar: familiar)
    self.hat = hat
  }
  
  func turnFamiliarIntoToad() throws -> Toad {
    // When have you ever seen a Witch perform a spell without her magical hat on ? :]
    guard let hat = hat where hat.isMagical else {
        throw ChangoSpellError.HatMissingOrNotMagical
    }

    // Check if witch has a familiar
    guard let familiar = familiar else {
        throw ChangoSpellError.NoFamiliar
    }
    
    // Check if familiar is already a toad - if so, why are you casting the spell?
    if familiar is Toad {
        throw ChangoSpellError.FamiliarAlreadyAToad
    }
    guard hasSpellOfType(.PrestoChango) else {
        throw ChangoSpellError.SpellNotKnownToWitch
    }
    
    // Check if the familiar has a name
    guard let name = familiar.name else {
        let reason = "Familiar doesn't have a name."
        throw ChangoSpellError.SpellFailed(reason: reason)
    }
    
    // It all checks out! Return a toad with the same name as the witch's familiar
    return Toad(name: name)  // This is an entirely new Toad.
  }
  
  func hasSpellOfType(type: MagicWords) -> Bool { // Check if witch currently has appropriate spell in their spellbook
    return spells.contains { $0.magicWords == type }
  }
}

func handleSpellError(error: ChangoSpellError) {
    let prefix = "Spell Failed."
    switch error {
    case .HatMissingOrNotMagical:
        print("\(prefix) Did you forget your hat, or does it need its batteries charged?")
    default:
        print(prefix)
    }
}

func exampleOne() {
    print("") // Add an empty line in the debug area
    
    let salem = Cat(name: "Salem Saberhagen")
    salem.speak()
    
    let witchOne = Witch(name: "Sabrina", familiar: salem)
    do {
        try witchOne.turnFamiliarIntoToad()
    }
    catch let error as ChangoSpellError {
        handleSpellError(error)
    }
    catch {
        print("Something went wrong, are you feeling OK?")
    }
}

exampleOne()
