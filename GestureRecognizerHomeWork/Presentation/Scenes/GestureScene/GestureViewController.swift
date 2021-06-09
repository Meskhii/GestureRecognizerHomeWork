//
//  GestureViewController.swift
//  GestureRecognizerHomeWork
//
//  Created by Admin on 09.06.2021.
//

import UIKit

class GestureViewController: UIViewController {

    @IBOutlet weak var xCoordinatLabel: UILabel!
    @IBOutlet weak var yCoordinatLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var gestureTag = Int()
    
    static private var pressStartTime: TimeInterval = 0.0
    static private var imageViewTranslationX: CGFloat = 0
    static private var imageViewTranslationY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        xCoordinatLabel.isHidden = true
        yCoordinatLabel.isHidden = true
        
        handleTappedChoice()
    }
    
    func handleTappedChoice() {
        switch gestureTag {
        case 0:
            panGesture()
        case 1:
            longPressGesture()
        case 2:
            swipeGesture()
        case 3:
            pinchGesture()
        default:
            break
        }
    }

    func panGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        imageView.addGestureRecognizer(panGesture)
    }
    
    func longPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        imageView.addGestureRecognizer(longPressGesture)
        
        xCoordinatLabel.isHidden = false
        yCoordinatLabel.isHidden = false
    }
    
    func swipeGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeDown.direction = .down
        imageView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        imageView.addGestureRecognizer(swipeUp)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        imageView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        imageView.addGestureRecognizer(swipeLeft)
    }
    
    func pinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imageView.addGestureRecognizer(pinchGesture)
        
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

extension GestureViewController {
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        switch gesture.state {
        case .changed:
            imageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            xCoordinatLabel.text = "X: \(velocity.x)"
            yCoordinatLabel.text = "Y: \(velocity.y)"
        default:
            break
        }
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        
        var duration: TimeInterval = 0
        
        switch gesture.state {
        case .began:
            GestureViewController.pressStartTime = NSDate.timeIntervalSinceReferenceDate
        case .ended:
            duration = NSDate.timeIntervalSinceReferenceDate - GestureViewController.pressStartTime
        default:
            break
        }
       
        if 0.01...1.0 ~= duration {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .right:
            GestureViewController.imageViewTranslationX += 50
            imageView.transform = CGAffineTransform(
                translationX: GestureViewController.imageViewTranslationX,
                y: GestureViewController.imageViewTranslationY)
        case .left:
            GestureViewController.imageViewTranslationX -= 50
            imageView.transform = CGAffineTransform(
                translationX: GestureViewController.imageViewTranslationX,
                y: GestureViewController.imageViewTranslationY)
        case .up:
            GestureViewController.imageViewTranslationY -= 50
            imageView.transform = CGAffineTransform(
                translationX: GestureViewController.imageViewTranslationX,
                y: GestureViewController.imageViewTranslationY)
        case .down:
            GestureViewController.imageViewTranslationY += 50
            imageView.transform = CGAffineTransform(
                translationX: GestureViewController.imageViewTranslationX,
                y: GestureViewController.imageViewTranslationY)
        default:
            break
        }
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
    
        switch gesture.state {
        case .changed:
            imageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
            
        case .ended:
            UIView.animate(withDuration: 0.3) {
                self.imageView.transform = .identity
            }
        default:
            break
        }
    }
    
}
