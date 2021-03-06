//
//  ReviewViewController.swift
//  Quotes
//
//  Created by David Park on 8/29/16.
//  Copyright © 2016 DavidVY. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseDatabase
import MLPAutoCompleteTextField

class ReviewViewController: UIViewController, UITextFieldDelegate, MLPAutoCompleteTextFieldDelegate, MLPAutoCompleteTextFieldDataSource {
	
	let shared = UserDataStore.sharedDataStore
	
	var quoteLabel = UILabel()
	var saidLabel = UILabel()
	var heardLabel = UILabel()
	var whenLabel = UILabel()

	var saidTextField = MLPAutoCompleteTextField()
	var heardTextField = MLPAutoCompleteTextField()		// to be buttons
	var whenMonthTextField = UITextField()
	var whenDayTextField = UITextField()
	var whenYearTextField = UITextField()

	var todayButton = UIButton()
	let today = NSDate()
	
	var quoteText: String?
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		quoteLabel.text = quoteText
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		quoteLabel.text = quoteText
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done🖋", style: UIBarButtonItemStyle.Done, target: self, action: #selector(doneButtonPressed))
		
		whenMonthTextField.delegate = self
		whenDayTextField.delegate = self
		whenYearTextField.delegate = self
		
		saidTextField.delegate = self
		saidTextField.autoCompleteDataSource = self
		heardTextField.delegate = self
		heardTextField.autoCompleteDataSource = self
		
		view.backgroundColor = UIColor.quotesBackgroundColor()
		setupScene()
	}
	
	func autoCompleteTextField(textField: MLPAutoCompleteTextField!, possibleCompletionsForString string: String!) -> [AnyObject]! {
		return Array(shared.userContacts.keys)
	}
	
	func doneButtonPressed() {
		
		if (whenMonthTextField.text == "" || whenDayTextField.text == "" || whenYearTextField.text == "" || saidTextField.text == "" || heardTextField.text == "") {
			let alertController = UIAlertController(title: "Wait!", message: "You forgot to fill something out!", preferredStyle: .Alert)
			let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
			})
			alertController.addAction(OKAction)
			presentViewController(alertController, animated: true, completion: nil)
		} else if (Int(whenMonthTextField.text!)! > 12 || Int(whenDayTextField.text!)! > 31) {
			let alertController = UIAlertController(title: "Huh?", message: "Please enter a valid date", preferredStyle: .Alert)
			let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
			})
			alertController.addAction(OKAction)
			presentViewController(alertController, animated: true, completion: nil)
			
		} else if (!shared.userContacts.keys.contains(saidTextField.text!) || (!shared.userContacts.keys.contains(heardTextField.text!))){
			let alertController = UIAlertController(title: "Who?", message: "this person does not exist in your contacts", preferredStyle: .Alert)
			let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in })
			alertController.addAction(OKAction)
			presentViewController(alertController, animated: true, completion: nil)
		} else {
			
			let alertController = UIAlertController(title: "Create Quote?", message: "Would you like to publish a new quote?", preferredStyle: .Alert)
			
			let OKAction = UIAlertAction(title: "Quote It", style: .Default) { (action) in
				
				//create a new QuoteQuote to databse
				//need to be set and updated with contacts
				
				let newQuoteRef = FIRDatabase.database().reference().child("QuoteQuote").childByAutoId()
				
				let authorId = self.shared.userContacts[self.saidTextField.text!]
				let author = self.saidTextField.text!
				let content = self.quoteText
				var heardBy = [String]()
				let month = String(format: "%02@", self.whenMonthTextField.text!)
				let day = String(format: "%02@", self.whenDayTextField.text!)
				heardBy.append(self.shared.userContacts[self.heardTextField.text!]!)
				let date = "\(month)/\(day)/\(self.whenYearTextField.text!)"
				
				let postData: [String: AnyObject] = ["authorId": authorId!, "author": author, "content": content!, "heardBy": heardBy, "date": date]
				
				newQuoteRef.setValue(postData)
				
				self.navigationController?.popViewControllerAnimated(true)
			}
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in }
			
			alertController.addAction(cancelAction)
			alertController.addAction(OKAction)
			
			presentViewController(alertController, animated: true, completion: nil)
		}
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		
		if (textField == whenMonthTextField) {
			if(textField.text!.characters.count - range.length + string.characters.count > 2) {
				return false
			}
		} else if (textField == whenDayTextField) {
			if(textField.text!.characters.count - range.length + string.characters.count > 2) {
				return false
			}
		} else if (textField == whenYearTextField) {
			if(textField.text!.characters.count - range.length + string.characters.count > 4) {
				return false
			}
		}
		return true
	}
	
	func todayButtonPressed() {
		
		print("todayButtonPressed")
		
		todayButton.buttonBounce()
		
		whenMonthTextField.text = String(format: "%02d", today.month())
		whenDayTextField.text = String(format: "%02d", today.day())
		whenYearTextField.text = String(today.year())
		
	}
	
	func setupScene() {
		
		let labelColor = UIColor.belizeHoleColor()
		let boxColor = UIColor.quotesBackgroundColor()
		let borderColor = UIColor.peterRiverColor()
		let labelFont = Constants.headerFont
		
		view.addSubview(saidTextField)
		saidTextField.snp_makeConstraints { (make) in
			make.centerX.equalTo(view.snp_centerX).multipliedBy(1.2)
			make.centerY.equalTo(view.snp_centerY).dividedBy(3)
			make.width.equalTo(view.snp_width).multipliedBy(0.6)
			make.height.equalTo(view.snp_height).dividedBy(14)
		}
		saidTextField.backgroundColor = boxColor
		saidTextField.layer.borderWidth = 1
		saidTextField.layer.borderColor = borderColor.CGColor
		
		view.addSubview(heardTextField)
		heardTextField.snp_makeConstraints { (make) in
			make.centerX.equalTo(saidTextField.snp_centerX)
			make.top.equalTo(saidTextField.snp_bottom).offset(10)
			make.width.equalTo(saidTextField.snp_width)
			make.height.equalTo(saidTextField.snp_height)
		}
		heardTextField.backgroundColor = boxColor
		heardTextField.layer.borderWidth = 1
		heardTextField.layer.borderColor = borderColor.CGColor
		
		view.addSubview(whenMonthTextField)
		whenMonthTextField.snp_makeConstraints { (make) in
			make.top.equalTo(heardTextField.snp_bottom).offset(10)
			make.left.equalTo(heardTextField.snp_left)
			make.width.equalTo(saidTextField.snp_width).dividedBy(3.25)
			make.height.equalTo(heardTextField.snp_height)
		}
		whenMonthTextField.backgroundColor = boxColor
		whenMonthTextField.layer.borderWidth = 1
		whenMonthTextField.layer.borderColor = borderColor.CGColor
		whenMonthTextField.placeholder = "MM"
		whenMonthTextField.textAlignment = .Center
		whenMonthTextField.keyboardType = .NumberPad
		
		view.addSubview(whenDayTextField)
		whenDayTextField.snp_makeConstraints { (make) in
			make.top.equalTo(whenMonthTextField.snp_top)
			make.left.equalTo(whenMonthTextField.snp_right).offset(10)
			make.width.equalTo(whenMonthTextField.snp_width)
			make.height.equalTo(whenMonthTextField.snp_height)
		}
		whenDayTextField.backgroundColor = boxColor
		whenDayTextField.layer.borderWidth = 1
		whenDayTextField.layer.borderColor = borderColor.CGColor
		whenDayTextField.placeholder = "DD"
		whenDayTextField.textAlignment = .Center
		whenDayTextField.keyboardType = .NumberPad
		
		view.addSubview(whenYearTextField)
		whenYearTextField.snp_makeConstraints { (make) in
			make.top.equalTo(whenDayTextField.snp_top)
			make.right.equalTo(heardTextField.snp_right)
			make.width.equalTo(whenDayTextField.snp_width)
			make.height.equalTo(whenDayTextField.snp_height)
		}
		whenYearTextField.backgroundColor = boxColor
		whenYearTextField.layer.borderWidth = 1
		whenYearTextField.layer.borderColor = borderColor.CGColor
		whenYearTextField.placeholder = "YYYY"
		whenYearTextField.textAlignment = .Center
		whenYearTextField.keyboardType = .NumberPad
		
		view.addSubview(todayButton)
		view.addSubview(quoteLabel)
		quoteLabel.snp_makeConstraints { (make) in
			make.centerX.equalTo(view.snp_centerX)
			make.height.equalTo(view.snp_height).dividedBy(6)
			make.width.equalTo(view.snp_width).multipliedBy(0.8)
			make.top.equalTo(todayButton.snp_bottom).offset(10)
		}
		quoteLabel.backgroundColor = boxColor
		quoteLabel.lineBreakMode = .ByWordWrapping
		quoteLabel.numberOfLines = 5
		quoteLabel.font = UIFont(name: Constants.headerFont, size: 18)
		quoteLabel.textColor = UIColor.peterRiverColor()
		
		view.addSubview(saidLabel)
		saidLabel.snp_makeConstraints { (make) in
			make.left.equalTo(quoteLabel.snp_left)
			make.top.equalTo(saidTextField.snp_top)
			make.bottom.equalTo(saidTextField.snp_bottom)
			make.right.equalTo(saidTextField.snp_left)
		}
		saidLabel.text = "SAID"
		//saidLabel.backgroundColor = UIColor.grayColor()
		saidLabel.textColor = labelColor
		saidLabel.font = UIFont(name: labelFont, size: saidLabel.font.pointSize)
		
		view.addSubview(heardLabel)
		heardLabel.snp_makeConstraints { (make) in
			make.left.equalTo(saidLabel.snp_left)
			make.top.equalTo(heardTextField.snp_top)
			make.bottom.equalTo(heardTextField.snp_bottom)
			make.right.equalTo(heardTextField.snp_right)
		}
		heardLabel.text = "HEARD"
		//heardLabel.backgroundColor = UIColor.darkGrayColor()
		heardLabel.textColor = labelColor
		heardLabel.font = UIFont(name: labelFont, size: heardLabel.font.pointSize)
		
		view.addSubview(whenLabel)
		whenLabel.snp_makeConstraints { (make) in
			make.left.equalTo(heardLabel.snp_left)
			make.top.equalTo(whenMonthTextField.snp_top)
			make.bottom.equalTo(whenMonthTextField.snp_bottom)
			make.right.equalTo(whenMonthTextField.snp_left)
		}
		whenLabel.text = "WHEN"
		//whenLabel.backgroundColor = UIColor.magentaColor()
		whenLabel.textColor = labelColor
		whenLabel.font = UIFont(name: labelFont, size: whenLabel.font.pointSize)
		
		//view.addSubview(todayButton)
		todayButton.snp_makeConstraints { (make) in
			make.left.equalTo(whenMonthTextField.snp_left)
			make.top.equalTo(whenMonthTextField.snp_bottom).offset(10)
			make.right.equalTo(whenYearTextField.snp_right)
			make.height.equalTo(whenMonthTextField.snp_height)
		}
		todayButton.setTitle("Today's Date", forState: .Normal)
		todayButton.addTarget(self, action: #selector(todayButtonPressed), forControlEvents: .TouchUpInside)
		todayButton.backgroundColor = UIColor.peterRiverColor()
		todayButton.layer.borderWidth = 2
		todayButton.layer.borderColor = UIColor.whiteColor().CGColor
		
	}

}
