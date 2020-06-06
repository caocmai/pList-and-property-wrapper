//
//  ViewController.swift
//  pListPractice
//
//  Created by Cao Mai on 6/3/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!
        let object = players[indexPath.row]
        let score = object["Score"] as! String
        let name = object["Name"] as! String
        cell.textLabel?.text = "\(score)    \(name)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highest Scores 🚀"
        
    }
    
    @IBOutlet weak var table: UITableView!
    var players: [AnyObject] = []
    let pListTest = Plist(name: "Property List")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Reading and Writing pList
                writePlist()
                getPlist()
        
        /// This is for property wrapper
        //        SettingsStruct.darkMode = true
        //        print(SettingsStruct.darkMode)
        //
        //        SettingsStruct.preferredlanguage = "SP"
        //        print(SettingsStruct.preferredlanguage)
        //
        //        SettingsStruct.preferredlanguage = "ML"
        //        print(SettingsStruct.preferredlanguage)
        //
        //        SettingsStruct.preferredlanguage = nil
        //        print(SettingsStruct.preferredlanguage)
        
        // This to add object to UserDefault
        let me = Person(name: "cao", favoriteColor: .blue)
        SettingsStruct.person = me
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(me) {
            UserDefaults.standard.set(encoded, forKey: "user") // Set encoded object to key "user"
        }
        print(SettingsStruct.person)
        
        
        let user = UserDefaults.standard.data(forKey: "user") // Get the user from the userDefault
        let decoder = JSONDecoder()
        if let decodedUser = try? decoder.decode(Person.self, from: user!) { // Need to decode the user to be able to get its information by decoding with the Person struct
            print(decodedUser.favoriteColor)
        }
        
        // Using the Plist methods
        //        if let plist = Plist(name: "Property List") {
        //            let dict = plist.getValuesInPlistFile()!
        //
        //            let scoresDict = dict["Scores"] as! NSMutableArray
        //
        //            let cao = ["Name": "Cao", "Score": "3"] as [String:Any]
        //
        //            do {
        //                try plist.addValuesToPlistFile(dictionary: dict)
        //            } catch {
        //                print(error)
        //            }
        //
        //            let newDict = plist.getMutablePlistFile()!
        ////            scores = newDict["Scores"] as! [[String:Any]]
        //        } else {
        //            print("Unable to get plist")
        //        }
        
    }
    
    
    func getPlist() {
        var format = PropertyListSerialization.PropertyListFormat.xml
        var data:[String:AnyObject] = [:]
        let path:String? = Bundle.main.path(forResource: "Property List", ofType: "plist")!
        let xmlContents = FileManager.default.contents(atPath: path!)!
        do{
            data = try PropertyListSerialization.propertyList(from: xmlContents,options: .mutableContainersAndLeaves,format: &format)as! [String:AnyObject]
            // data is available now
            players = (data["Scores"]) as! [AnyObject]
            let me = data["Scores"] as! [[String:Any]]
            //            print(players)
        }
        catch{
            print("Error reading plist: \(error)")
        }
    }
    
    func writePlist() {
        let path: String? = Bundle.main.path(forResource: "Property List", ofType: "plist")!
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path!) {
            guard let dict = NSMutableDictionary(contentsOfFile: path!) else {return}
            let scoresDict = dict["Scores"] as! NSMutableArray
            let cao = ["Name": "Cao", "Score": "12"] as [String:Any]
            let cao2 = ["Name": "Cao2", "Score": "122"] as [String:Any]
            
            scoresDict.add(cao)
            scoresDict.add(cao2)
            //            let filManager = FileManager.default
            if fileManager.fileExists(atPath: path!) {
                if !dict.write(toFile: path!, atomically: false) {
                    print("File not written sucessfully")
                }
            }
        }
    }
    
}


