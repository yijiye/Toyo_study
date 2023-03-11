//
//  main.swift
//  gameCharacter
//
//  Created by jiye Yi on 2023/02/04.
//

import Foundation


class Character {
    var health = 100
    
    var attack: (Opponent) -> Void = { a in
        /*
         let opponent = Opponent()를 안에서 인스턴스로 만들어 주는것이 아니라 attack이란 프로퍼티의 클로저 안에 타입으로 선언할 수 있다.
         매개변수를 가질 수 없기 때문에 (a: Opponent) 라는 식으로는 사용할 수 없고
         (_ a: Opponent) 처럼 와일드카드를 사용해서는 가능하다.
         */
        a.health -= 10
    }
    
    var defense: (Character) -> Void = { b in
        b.health += 5
    }
    
    func tabShiftKey(skill: (Opponent) -> Void) {
        skill(game.opponentB)
    }
}

class Opponent {
    var health = 100
}

class Game {
    var opponentB = Opponent()
}

let game = Game()
let opponentA = Opponent()
let riji = Character()
riji.tabShiftKey(skill: riji.attack)
print(opponentA.health)

/*
 - 후행클로저로 표현하려면 `{ }` 이 중괄호 자체가 함수(클로저)를 의미한다.
 - 따라서 { character.a } 자체가 함수안에 함수 이름이 또 존재하는 것이기 때문에 character.a 함수가 사용되지 않았다는 에러 문구가 뜸
 - character.a() 로 호출시켜주면 에러 문구가 사라짐
 */


