//
//  Joke+CoreDataProperties.swift
//  CoreDataTraining2
//
//  Created by kimseongjun on 2023/04/13.
//
//

import Foundation
import CoreData


extension Joke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        return NSFetchRequest<Joke>(entityName: "Joke")
    }


}

extension Joke : Identifiable {

}
