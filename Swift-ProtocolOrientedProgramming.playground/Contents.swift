// https://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2

// Protocol-Oriented Programming in Swift 2

import UIKit

protocol Bird: BooleanType {
    var name: String { get }
    var canFly: Bool { get }
}

extension BooleanType where Self: Bird {
    var boolValue: Bool {
        return self.canFly
    }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}

struct FlappyBird: Bird, Flyable {
    let name: String
    
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
    let canFly = false
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double
    
    var airspeedVelocity: Double { return 2000.0 }
}


// Protocol extension
// Swift 1.2 introduced this where syntax to if-let binding, and Swift 2 brings that power to conditionally extend a protocol.
extension Bird where Self: Flyable {
    // Flyable birds can fly!
    var canFly: Bool { return true }
}

/*
    Why Not Base Classes?

    Protocol extensions and default implementations may seem similar to using a base class or even abstract classes in other languages, but they offer a few key advantages in Swift:
    Because types can conform to more than one protocol, they can be decorated with default behaviors from multiple protocols. Unlike multiple inheritance of classes which some programming languages support, protocol extensions do not introduce any additional state.
    Protocols can be adopted by classes, structs and enums. Base classes and inheritance are restricted to class types.
    In other words, protocol extensions provide the ability to define default behavior for value types and not just classes.
 
*/

enum UnladenSwallow: Bird, Flyable {
    case African
    case European
    case Unknown
    
    var name: String {
        switch self {
            case .African:
                return "African"
            case .European:
                return "European"
            case .Unknown:
                return "What do you mean? African or European?"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
            case .African:
                return 10.0
            case .European:
                return 9.9
            case .Unknown:
                fatalError("You are thrown from the bridge of death!")
        }
    }
}

extension CollectionType {
    func skip(skip: Int) -> [Generator.Element] {
        guard skip != 0 else { return [] }
        
        var index = self.startIndex
        var result: [Generator.Element] = []
        var i = 0
        repeat {
            if i % skip == 0 {
                result.append(self[index])
            }
            index = index.successor()
            i += 1
        } while (index != self.endIndex)
        
        return result
    }
}


let bunchaBirds: [Bird] =
    [UnladenSwallow.African,
     UnladenSwallow.European,
     UnladenSwallow.Unknown,
     Penguin(name: "King Penguin"),
     SwiftBird(version: 2.0),
     FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0)]

bunchaBirds.skip(3)

if UnladenSwallow.African.canFly {
    print("I can fly!")
} else {
    print("Guess I’ll just sit here :[")
}


// Counts the number of characters in the array
["frog", "pants"].map { $0.length }.reduce(0) { $0 + $1 } // returns 9

func topSpeed<T: CollectionType where T.Generator.Element == Flyable>(c: T) -> Double {
    return c.map { $0.airspeedVelocity }.reduce(0) { max($0, $1) }
}

let flyingBirds: [Flyable] =
    [UnladenSwallow.African,
     UnladenSwallow.European,
     SwiftBird(version: 2.0)]

topSpeed(flyingBirds) // 2000.0
