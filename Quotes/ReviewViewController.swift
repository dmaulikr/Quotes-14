//
//  ReviewViewController.swift
//  Quotes
//
//  Created by David Park on 8/29/16.
//  Copyright © 2016 DavidVY. All rights reserved.
//

import UIKit
import SnapKit

class ReviewViewController: UIViewController {
	
	var saidLabel = UILabel()
	var heardLabel = UILabel()
	var whenLabel = UILabel()

	var saidTextField = UITextField()
	var heardTextField = UITextField()
	var whenMonthTextField = UITextField()
	var whenDayTextField = UITextField()
	var whenYearTextField = UITextField()
	
	var quoteLabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done🖋", style: UIBarButtonItemStyle.Done, target: self, action: #selector(doneButtonPressed))
		
		view.backgroundColor = UIColor.blueColor()
		
		setupScene()
	}
	
	func doneButtonPressed() {
		
		let alertController = UIAlertController(title: "Create Quote?", message: "Would you like to publish a new quote?", preferredStyle: .Alert)
		
		let OKAction = UIAlertAction(title: "Quote It", style: .Default) { (action) in
			self.navigationController?.popViewControllerAnimated(true)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in }
		
		alertController.addAction(cancelAction)
		alertController.addAction(OKAction)
		
		presentViewController(alertController, animated: true, completion: nil)
	}
	
	func setupScene() {
		
		view.addSubview(saidTextField)
		saidTextField.snp_makeConstraints { (make) in
			make.centerX.equalTo(view.snp_centerX).multipliedBy(1.2)
			make.centerY.equalTo(view.snp_centerY).dividedBy(3)
			make.width.equalTo(view.snp_width).multipliedBy(0.67)
			make.height.equalTo(view.snp_height).dividedBy(12)
		}
		saidTextField.backgroundColor = UIColor.alizarinColor()
		
		view.addSubview(heardTextField)
		heardTextField.snp_makeConstraints { (make) in
			make.centerX.equalTo(saidTextField.snp_centerX)
			make.top.equalTo(saidTextField.snp_bottom).offset(10)
			make.width.equalTo(saidTextField.snp_width)
			make.height.equalTo(saidTextField.snp_height)
		}
		heardTextField.backgroundColor = UIColor.amethystColor()
		
		view.addSubview(whenMonthTextField)
		whenMonthTextField.snp_makeConstraints { (make) in
			make.top.equalTo(heardTextField.snp_bottom).offset(10)
			make.left.equalTo(heardTextField.snp_left)
			make.width.equalTo(saidTextField.snp_width).dividedBy(3.25)
			make.height.equalTo(heardTextField.snp_height)
		}
		whenMonthTextField.backgroundColor = UIColor.carrotColor()
		
		view.addSubview(whenDayTextField)
		whenDayTextField.snp_makeConstraints { (make) in
			make.top.equalTo(whenMonthTextField.snp_top)
			make.left.equalTo(whenMonthTextField.snp_right).offset(10)
			make.width.equalTo(whenMonthTextField.snp_width)
			make.height.equalTo(whenMonthTextField.snp_height)
		}
		whenDayTextField.backgroundColor = UIColor.cyanColor()
		
		view.addSubview(whenYearTextField)
		whenYearTextField.snp_makeConstraints { (make) in
			make.top.equalTo(whenDayTextField.snp_top)
			make.right.equalTo(heardTextField.snp_right)
			make.width.equalTo(whenDayTextField.snp_width)
			make.height.equalTo(whenDayTextField.snp_height)
		}
		whenYearTextField.backgroundColor = UIColor.emeraldColor()
		
		view.addSubview(quoteLabel)
		quoteLabel.snp_makeConstraints { (make) in
			make.center.equalTo(view.snp_center)
			make.height.equalTo(view.snp_height).dividedBy(8)
			make.width.equalTo(view.snp_width).multipliedBy(0.9)
		}
		quoteLabel.backgroundColor = UIColor.greenSeaColor()
		
		view.addSubview(saidLabel)
		saidLabel.snp_makeConstraints { (make) in
			make.left.equalTo(quoteLabel.snp_left)
			make.top.equalTo(saidTextField.snp_top)
			make.bottom.equalTo(saidTextField.snp_bottom)
			make.right.equalTo(saidTextField.snp_left)
		}
		saidLabel.text = "SAID"
		saidLabel.backgroundColor = UIColor.grayColor()
		
		view.addSubview(heardLabel)
		heardLabel.snp_makeConstraints { (make) in
			make.left.equalTo(saidLabel.snp_left)
			make.top.equalTo(heardTextField.snp_top)
			make.bottom.equalTo(heardTextField.snp_bottom)
			make.right.equalTo(heardTextField.snp_right)
		}
		heardLabel.text = "HEARD"
		heardLabel.backgroundColor = UIColor.darkGrayColor()
		
		view.addSubview(whenLabel)
		whenLabel.snp_makeConstraints { (make) in
			make.left.equalTo(heardLabel.snp_left)
			make.top.equalTo(whenMonthTextField.snp_top)
			make.bottom.equalTo(whenMonthTextField.snp_bottom)
			make.right.equalTo(whenMonthTextField.snp_left)
		}
		whenLabel.text = "WHEN"
		whenLabel.backgroundColor = UIColor.magentaColor()
		
		
	}

}