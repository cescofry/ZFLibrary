//
//  ZFRCoreData.swift
//  Pods
//
//  Created by Francesco Frison on 6/11/14.
//
//

import Foundation
import CoreData


struct ZFRCoreDataConfig {
    var mocName : String
    var dbName : String
    
    init (mocName : String) {
        self.mocName = mocName
        self.dbName = ZFRCoreDataConfig.dbNameFromMocName(mocName)
    }
    
    init() {
        self.mocName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName") as String
        self.dbName = ZFRCoreDataConfig.dbNameFromMocName(self.mocName)
    }
    
    static func dbNameFromMocName(mocName: String) -> String {
        var dbName : String
        #if DEBUG
            dbName = "\(mocName).sqlite"
            #else
            dbName = "test-\(mocName).sqlite"
        #endif
        return dbName
    }

}

class ZFRCoreData {
    
    
    var config : ZFRCoreDataConfig {
    get {
        return ZFRCoreDataConfig()
    }
    }
    
    var managedObjectModel : NSManagedObjectModel? {
    get {
        
        
        var url = NSBundle().URLForResource(self.config.mocName, withExtension: "momd")
        if !url {
            url = NSBundle().URLForResource(self.config.mocName, withExtension: "mom")
        }
        
        return NSManagedObjectModel(contentsOfURL: url)
    }
    }
    
    var persistentStoreCoordinator :NSPersistentStoreCoordinator? {
    get {
        let storeC : NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        if !storeC {
            return nil
        }
        
        let storeURL = NSBundle.mainBundle().resourceURL.URLByAppendingPathComponent(self.config.dbName)
        
        var options : Dictionary<String, Bool> = Dictionary()
        options[NSMigratePersistentStoresAutomaticallyOption] = true
        options[NSInferMappingModelAutomaticallyOption] = true
        
        storeC!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options, error:nil)
        return storeC
    }
    }
    var managedObjectContext: NSManagedObjectContext? {
    get {
        let moc : NSManagedObjectContext? = NSManagedObjectContext()
        if !moc {
            return nil
        }
        moc!.persistentStoreCoordinator = self.persistentStoreCoordinator
        return moc
    }
    }
    

}
