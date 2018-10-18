//
//  ViewController.swift
//  Drop Demo
//
//  Created by Evgeniy Leychenko on 10/17/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    // MARK: - Actions -
    
    @IBAction private func showDefault(_ sender: UIButton) {
        Drop.down(SampleText.short)
    }
    
    @IBAction private func showInfo(_ sender: UIButton) {
        Drop.down(SampleText.long, type: .info)
    }
    
    @IBAction private func showSuccess(_ sender: UIButton) {
        Drop.down(SampleText.short, type: .success)
    }
    
    @IBAction private func showWarning(_ sender: UIButton) {
        Drop.down(SampleText.medium, type: .warning)
    }
    
    @IBAction private func showError(_ sender: UIButton) {
        Drop.down(SampleText.medium, type: .error)
    }
    
    @IBAction private func showColor(_ sender: UIButton) {
        Drop.down(SampleText.medium, type: .color(.random))
    }
    
    @IBAction private func showWithAction(_ sender: UIButton) {
        Drop.down(SampleText.medium) { [unowned self] in
            self.fireAction()
        }
    }
    
    @IBAction private func showBlur(_ sender: UIButton) {
        Drop.down(SampleText.medium, type: .blur(.dark))
    }
    
    @IBAction private func showCustom(_ sender: UIButton) {
        Drop.down(SampleText.medium, type: CustomDrop.blackGreen)
    }
    
    @IBAction private func showWithDuration(_ sender: UIButton) {
        Drop.down(SampleText.short, duration: 0.5)
    }
    
    @IBAction private func hideAll(_ sender: UIButton) {
        Drop.upAll()
    }
    
    // MARK: - Private -
    
    private func fireAction() {
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let controller = UIAlertController(title: "Action", message: "Action fired!", preferredStyle: .alert)
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
}
