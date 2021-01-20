//
//  ExpandableView.swift
//  ExpandableCard
//
//  Created by Julian Panucci on 1/20/21.
//

import UIKit

enum ExpandableViewState {
	case expanded, collapsed
}

enum ExpandableViewDirection {
	case vertical, horizontal
}

class ExpandableView: UIView {
	var view1: UIView
	var view2: UIView
	
	var state: ExpandableViewState = .collapsed
	var direction: ExpandableViewDirection = .vertical
	
	private var heightConstraint = NSLayoutConstraint()
	private var widthConstraint = NSLayoutConstraint()

	init(frame: CGRect, view1: UIView, view2: UIView, direction: ExpandableViewDirection = .vertical) {
		self.view1 = view1
		self.view2 = view2
		super.init(frame: frame)
		
		self.direction = direction
  
		self.clipsToBounds = true
		self.addSubview(view1)
		self.addSubview(view2)
		
		isUserInteractionEnabled = true
		view1.isUserInteractionEnabled = true

		view1.translatesAutoresizingMaskIntoConstraints = false
		view2.translatesAutoresizingMaskIntoConstraints = false
		
		
		heightConstraint = self.heightAnchor.constraint(equalToConstant: view1.frame.height)
		widthConstraint = self.widthAnchor.constraint(equalToConstant: view2.frame.width)
		
		if direction == .vertical {
			heightConstraint.isActive = true
			widthConstraint.isActive = true
		} else {
			widthConstraint.isActive = true
			heightConstraint.isActive = true
		}
		
		setConstraints()
	}
	
	private func setConstraints() {
		if direction == .vertical {
			NSLayoutConstraint.activate([
				view1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
				view1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
				view1.topAnchor.constraint(equalTo: self.topAnchor),
				view1.heightAnchor.constraint(equalToConstant: view1.frame.height),
				
				view2.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
				view2.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
				view2.topAnchor.constraint(equalTo: view1.bottomAnchor),
				view2.heightAnchor.constraint(equalToConstant: view2.frame.height),
			])
		} else if direction == .horizontal {
			NSLayoutConstraint.activate([
				view1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
				view1.widthAnchor.constraint(equalToConstant: view1.frame.width),
				view1.topAnchor.constraint(equalTo: self.topAnchor),
				view1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
				
				
				view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor),
				view2.topAnchor.constraint(equalTo: self.topAnchor),
				view2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
				view2.widthAnchor.constraint(equalToConstant: view2.frame.width),
			])
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func firstViewTapped() {
		if self.state == .expanded {
			change(state: .collapsed)
		} else {
			change(state: .expanded)
		}
	}
	
	func change(state: ExpandableViewState) {
		self.state = state
		
		if direction == .vertical {
			self.heightConstraint.constant = view1.frame.height + (state == .expanded ? view2.frame.height : 0)
		} else {
			self.widthConstraint.constant = view1.frame.width + (state == .expanded ? view2.frame.width : 0)
		}
		
		
		UIView.animate(withDuration: 0.5) {
			self.superview?.layoutIfNeeded()
		}
	}
}

