//
//  ViewController.swift
//  GestureRecognizerHomeWork
//
//  Created by Admin on 09.06.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var panGestureLabel: UILabel!
    @IBOutlet weak var longPressGestureLabel: UILabel!
    @IBOutlet weak var swipeGestureLabel: UILabel!
    @IBOutlet weak var pinchGestureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPanGesture()
        setupLongPressGesture()
        setupSwipeGestureLabel()
        setupPinchGestureLabel()
        
    }
    
    private func setupPanGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.panGestureTapped))
        panGestureLabel.isUserInteractionEnabled = true
        panGestureLabel.addGestureRecognizer(tap)
    }
    
    private func setupLongPressGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.panLongPressGestureTapped))
        longPressGestureLabel.isUserInteractionEnabled = true
        longPressGestureLabel.addGestureRecognizer(tap)
    }
    
    private func setupSwipeGestureLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.panSwipeGestureTapped))
        swipeGestureLabel.isUserInteractionEnabled = true
        swipeGestureLabel.addGestureRecognizer(tap)
    }
    
    private func setupPinchGestureLabel() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.panPinchGestureTapped))
        pinchGestureLabel.isUserInteractionEnabled = true
        pinchGestureLabel.addGestureRecognizer(tap)
    }

    @objc func panGestureTapped(_ sender: UITapGestureRecognizer) {
        moveToGestoreVC(with: 0)
    }
    
    @objc func panLongPressGestureTapped(_ sender: UITapGestureRecognizer) {
        moveToGestoreVC(with: 1)
    }
    
    @objc func panSwipeGestureTapped(_ sender: UITapGestureRecognizer) {
        moveToGestoreVC(with: 2)
    }
    
    @objc func panPinchGestureTapped(_ sender: UITapGestureRecognizer) {
        moveToGestoreVC(with: 3)
    }
    
    private func moveToGestoreVC(with tag: Int) {
        let sb = UIStoryboard(name: "GestureViewController", bundle: nil)
        let gestureVC = sb.instantiateViewController(withIdentifier: "GestureViewController") as! GestureViewController
        
        gestureVC.gestureTag = tag
        
        self.navigationController?.pushViewController(gestureVC, animated: true)
    }

}
