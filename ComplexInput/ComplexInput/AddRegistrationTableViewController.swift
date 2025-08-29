//
//  AddRegistrationTableViewController.swift
//  ComplexInput
//
//  Created by Simran on 27/08/25.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    func selectRoomTypeTableViewControllerDelegate(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    var registration: Registration? {

        guard let roomType = roomType else { return nil }

        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = CheckInDatePicker.date
        let checkOutDate = CheckOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn

        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            wifi: hasWifi,
                            roomType: roomType)
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var CheckInDateLabel: UILabel!
    @IBOutlet weak var CheckInDatePicker: UIDatePicker!
    @IBOutlet weak var lastNameTextField: UITextField!
  
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var CheckOutDateLabel: UILabel!
    @IBOutlet weak var CheckOutDatePicker: UIDatePicker!
    @IBOutlet weak var emailTextField: UITextField!
    
    var roomType: RoomType?
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)

    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)

    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            CheckInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }

    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            CheckOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        CheckInDatePicker.minimumDate = midnightToday
        CheckInDatePicker.date = midnightToday
        CheckOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: CheckInDatePicker.date)
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests( )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
        }
        else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
            isCheckOutDatePickerVisible.toggle()
        }
        else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        }
        else {
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false :
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false :
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
//    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
//        let firstName = firstNameTextField.text ?? ""
//        let lastName = lastNameTextField.text ?? ""
//        let email = emailTextField.text ?? ""
//        let checkInDate = CheckInDatePicker.date
//        let checkOutDate = CheckOutDatePicker.date
//        let numberOfAdults = Int(numberOfAdultsStepper.value)
//        let numberOfChildren = Int(numberOfChildrenStepper.value)
//        let hasWifi = wifiSwitch.isOn
//        let roomChoice = roomType?.name ?? "Not Set"
//        
//        print("DONE TAPPED")
//        print("firstName: \(firstName)")
//        print("lastName: \(lastName)")
//        print("email: \(email)")
//        print("checkIn: \(checkInDate)")
//        print("checkOut: \(checkOutDate)")
//        print("numberOfAdults: \(numberOfAdults)")
//        print("numberOfChildren: \(numberOfChildren)")
//        print("wifi \(hasWifi)")
//        print("roomType \(roomChoice)")
//    }
//    
    func updateDateViews() {
        CheckInDateLabel.text = CheckInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        CheckOutDateLabel.text = CheckOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController =  SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
        
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews( )
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

        
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
