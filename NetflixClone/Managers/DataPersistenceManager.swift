 //
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by Enes Özkırdeniz on 28.09.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabasError : Error {
        case failedToSaveData
        case failedToFetchData
        case failedDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model : Title , completion : @escaping (Result<Void, Error>) -> Void) {
     
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id ?? 0)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count ?? 0)
        item.vote_average = Int64(model.vote_average ?? 0)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabasError.failedToSaveData))
        }
        
    }
    
    func fetchingTitlesFromDataBase(completion : @escaping (Result<[TitleItem], Error >) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            
            let titles = try context.fetch(request)
            completion(.success(titles))
            
        } catch {
            completion(.failure(DatabasError.failedToFetchData))
        }
        
    }
    
    
    func deleteTitleWith(model : TitleItem, completion : @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabasError.failedDeleteData))
        }
    }
}
