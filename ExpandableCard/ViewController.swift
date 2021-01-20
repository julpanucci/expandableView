//
//  ViewController.swift
//  ExpandableCard
//
//  Created by Julian Panucci on 10/29/20.
//

import UIKit



class ViewController: UIViewController {
	
	var data = ["Hello", "Test", "Julian is cool", "Panucci" ,"This is fun"]
    
    let cardView: ExpandableView = {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        view1.backgroundColor = .red
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))

        let view = ExpandableView(frame: .zero, view1: view1, view2: view2, direction: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let cardView2: ExpandableView = {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))

        let view = ExpandableView(frame: .zero, view1: view1, view2: view2)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let cardView3: ExpandableView = {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))

        let view = ExpandableView(frame: .zero, view1: view1, view2: view2)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .white
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
	
	var tableView = UITableView()
	var cardView4: ExpandableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(cardView)
        self.view.addSubview(cardView2)
		let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 300))
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.tableFooterView = UIView()
		tableView.reloadData()

		cardView4 = ExpandableView(frame: .zero, view1: view1, view2: tableView)
		cardView4.translatesAutoresizingMaskIntoConstraints = false

		cardView4.backgroundColor = .white
		cardView4.layer.borderWidth = 2.0
		cardView4.layer.borderColor = UIColor.black.cgColor
		cardView4.layer.cornerRadius = 10.0
		self.view.addSubview(cardView4)
        
        setConstraints()
    }

    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cardView.heightAnchor.constraint(equalToConstant: 60),
            
            cardView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardView2.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            
            cardView4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardView4.topAnchor.constraint(equalTo: cardView2.bottomAnchor, constant: 20),
        ])
    }
}

extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
			cell.textLabel?.text = data[indexPath.row]
			cell.contentView.backgroundColor = .red
			return cell
		}
		
		return UITableViewCell()
	}
}
