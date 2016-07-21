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


// ----------------------------------------------------------------------------
// Example One - Avoiding Swift errors using nil (failable initializers)
// ----------------------------------------------------------------------------

enum MagicWords: String {
  case Abracadbra = "abracadabra"
  case Alakazam = "alakazam"
  case HocusPocus = "hocus pocus"
  case PrestoChango = "presto chango"
}

struct Spell: MagicalTutorialObject {
  var magicWords: MagicWords = .Abracadbra
  var avatar = "💫"
}

extension Spell {
/*
  static func createWithMagicWords(words: String) -> Spell? {
    if let incantation = MagicWords(rawValue: words) {
      var spell = Spell()
      spell.magicWords = incantation
      return spell
    }
    else {
      return nil
    }
  }
 */

/*
    init?(words: String) {
        if let incantation = MagicWords(rawValue: words) {
            self.magicWords = incantation
        }
        else {
            return nil
        }
    }
 */
    init?(words: String) {
        guard let incantation = MagicWords(rawValue: words) else {
            return nil
        }
        self.magicWords = incantation
    }
}

/*
let first = Spell.createWithMagicWords("abracadabra")
let second = Spell.createWithMagicWords("ascendio")
*/
let first = Spell(words: "abracadabra")
let second = Spell(words: "ascendio")

