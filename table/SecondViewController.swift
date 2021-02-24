//
//  SecondViewController.swift
//  table
//
//  Created by harpanth kaur on 2021-01-24.
//

import UIKit
import CoreData
class SecondViewController: UIViewController {
    var savedItems = [Labtest1]() // array ofitems
       var moc: NSManagedObjectContext!
       let context = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = context?.persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
    }
  
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var tution:UITextField!
    @IBOutlet weak var termdate:UITextField!
    @IBAction func startdate(_ sender: UITextField) {
            let datePickerView = UIDatePicker()
            datePickerView.datePickerMode = .dateAndTime
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action:
                                        #selector(handleDatePicker(sender:)), for: .valueChanged)
        }
    @objc func handleDatePicker(sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            termdate.text = dateFormatter.string(from: sender.date)
        }
    @IBAction func savebutton(_ sender: UIButton) {
        let alarmItem = Labtest1(context: moc)

         //true/false button checker
        
//var date = Date()
        alarmItem.name = username.text
        alarmItem.tution = Double(tution.text!) ?? 00.0
      //  alarmItem.termstartdate = date(termdate.text)
        alarmItem.age = Int16(age.text!)!
        
        context?.saveContext()
   //     tableview.reload()
            getallitems()
      
       // performSegue(withIdentifier: "passdata", sender: self)
        }
    
    func getallitems()
{
    do{
        let   _:NSFetchRequest<Labtest1> = Labtest1.fetchRequest()
        DispatchQueue.main.async {
           // tableview.reloadData()
        }
    }
 
}
    func createitem(name: String, age: Int , tution: Double , termstartdate:Date)

    {
        let newitem = Labtest1(context: moc)
        newitem.name = name
        newitem.age = Int16(age)
        newitem.tution = tution
        newitem.termstartdate=Date()
        do
        {context?.saveContext()
            getallitems()
            
        }
    
    }}

