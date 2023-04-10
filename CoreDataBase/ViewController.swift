//
//  ViewController.swift
//  CoreDataBase
//
//  Created by R93 on 06/04/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nametextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func adddataButtonAction(_ sender: UIButton) {
        if let x = idTextField.text,let y = Int(x),let a = numberTextField.text ,let b = Int(a)
        {
            addData(id: y, name: nametextField.text ??  "", number: b)
        }
    }
    @IBAction func deleteDataButtonAction(_ sender: UIButton) {
        if let x = idTextField.text,let y = Int(x)   
        {
            removeData(id: y)
        }
    }
    func addData(id:Int,name:String,number:Int)
    {
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContex = appDeleget.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Student", in: manageContex)!
        let user = NSManagedObject(entity: userEntity, insertInto: manageContex)
        user.setValue(name, forKey: "name")
        user.setValue(id, forKey: "id")
        user.setValue(number, forKey: "number")
        print(user)
    }
    
    @IBAction func getDataButtonAction(_ sender: Any) {
        getdata()
    }
    
    func getdata()
    {
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContex = appDeleget.persistentContainer.viewContext
        let fetchRequest = Student.fetchRequest()
        do
        {
            let result = try manageContex.fetch(fetchRequest)
            for data in result
            {
                print(data.id,data.name as! String,data.number)
            }
        
        }
        catch{
            print("Data Not Get")
        }
    }
        
    
    func upatedata()
    {
    }
        func removeData(id:Int)
    {
        guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContex = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do
        {
            let test = try manageContex.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
           manageContex.delete(objectToDelete)
            appDeleget.saveContext()
            print("Delete Data")
        }
        catch
        {
            print("Error")
        }
    }
}



