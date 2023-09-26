//
//  RecipeManager.swift
//  RecipeSaver
//
//  Created by Leart Bytyci on 26.9.23.
//

import Foundation
import CoreData

class RecipeManager: ObservableObject {
    var moc: NSManagedObjectContext // Accept the managed object context as a parameter

    @Published var isFavoriteRecipes: Set<NSManagedObjectID> = []

    init(context: NSManagedObjectContext) {
        self.moc = context
    }

    func toggleFavorite(_ recipe: Food) {
        if isFavoriteRecipes.contains(recipe.objectID) {
            isFavoriteRecipes.remove(recipe.objectID)
            recipe.isFavorite = false
        } else {
            isFavoriteRecipes.insert(recipe.objectID)
            recipe.isFavorite = true
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try moc.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
