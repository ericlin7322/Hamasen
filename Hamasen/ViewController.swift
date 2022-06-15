//
//  ViewController.swift
//  Hamasen
//
//  Created by Eric Lin on 2018/12/9.
//  Copyright © 2018 Eric Lin. All rights reserved.
//

import UIKit

extension ViewController: RotaryDialDelegate {
    func value(number: Int) {
        year.append(number)
        
        screenView.text = String(yearSum())
        
        for i in 0..<years.count {
            if years[i] == String(yearSum()){
                phoneBook.cellForRow(at: IndexPath(row: i, section: 0))?.textLabel?.text = yearsDetail[i]
                phoneBook.cellForRow(at: IndexPath(row: i, section: 0))?.isHighlighted = true
                buttonPress()
            }
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var phoneBookStatus = false
    var rotaryDial = RotaryDial()
    var screenView = UILabel()
    var phoneBook = PhoneBook()
    var button = UIButton()
    var year: [Int] = []
    var years = ["1907", "1913", "1927", "1939", "1941"]
    var yearsDetail = ["1907年 打狗尋常高等小學校建立", "1913年 打狗郵便局建立", "1927年 日本人完成高雄漁港", "1939年 市役所遷移至榮町", "1941年 高雄驛遷移至大港埔"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = years[indexPath.item]
        cell.backgroundColor = .gray
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(rotaryDial)
        view.addSubview(screenView)
        view.addSubview(button)
        view.addSubview(phoneBook)
        
        phoneBook.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        phoneBook.delegate = self
        phoneBook.dataSource = self
        phoneBook.backgroundColor = .gray
        
        screenView.textAlignment = .center
        screenView.font = UIFont(name: "Helvetica", size: 100)
        
        rotaryDial.delegate = self
        
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        button.backgroundColor = UIColor.blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rotaryDial.frame = CGRect(x: 0, y: view.safeAreaInsets.top + view.bounds.height / 5, width: min(view.bounds.width, view.bounds.height), height: min(view.bounds.width, view.bounds.height))
        screenView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 5)
        phoneBook.frame = CGRect(x: 0, y: view.frame.maxY, width: view.bounds.width, height: view.bounds.height * 2 / 3)
        button.frame = CGRect(origin: view.center, size: CGSize(width: min(view.bounds.width, view.bounds.height) / 4, height: min(view.bounds.width, view.bounds.height) / 4))
        button.center = view.center
        button.layer.cornerRadius = CGFloat.pi * 2
        phoneBook.commonInit()
        rotaryDial.center = view.center
        rotaryDial.commonInit()
    }
    
    @objc func buttonPress() {
        year.removeAll()
        screenView.text = ""
        if phoneBookStatus != true {
            UIView.animate(withDuration: 0.4, animations: {
                self.phoneBook.frame.origin.y = self.view.center.y + self.view.bounds.height / 8
                self.phoneBookStatus = true
            })
        }else {
            UIView.animate(withDuration: 0.4, animations: {
                self.phoneBook.frame.origin.y = self.view.bounds.maxY
                self.phoneBookStatus = false
            })
        }
    }
    
    func yearSum() -> Int {
        var value = 0
        for i in (0..<year.count).reversed() {
            value += year[i] * Int(pow(10.0, Double(year.count - i - 1)))
        }
        return value
    }
    
}

