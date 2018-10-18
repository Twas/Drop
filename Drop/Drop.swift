//
//  Drop.swift
//  Drop
//
//  Created by Evgeniy Leychenko on 10/17/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

public typealias DropAction = () -> Void

public final class Drop: UIView {
    
    private var statusLabel: UILabel?
    private var minimumHeight: CGFloat { return UIApplication.shared.statusBarFrame.height + 44.0 }
    private var topConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var duration: TimeInterval = Defaults.dropDuration
    
    private var upTimer: Timer?
    private var startTop: CGFloat = 0
    
    private var action: DropAction?
    
    // MARK: - Lifecycle -
    
    convenience init(duration: Double) {
        self.init(frame: CGRect.zero)
        self.duration = duration
        
        scheduleUpTimer(duration)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        stopUpTimer()
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Internal -
    
    func up() {
        scheduleUpTimer(0.0)
    }
    
    // MARK: - Actions -
    
    @objc private func up(_ sender: AnyObject) {
        action?()
        up()
    }
    
    @objc private func pan(_ sender: AnyObject) {
        guard let pan = sender as? UIPanGestureRecognizer else { return }
        switch pan.state {
        case .began:
            stopUpTimer()
            startTop = topConstraint?.constant ?? 0
        case .changed:
            let translation = pan.translation(in: window)
            let top = startTop + translation.y
            if top > 0.0 {
                topConstraint?.constant = top * 0.2
            } else {
                topConstraint?.constant = top
            }
        case .ended:
            startTop = 0
            guard let topConstraint = topConstraint else { return }
            if topConstraint.constant < 0.0 {
                scheduleUpTimer(0.0)
            } else {
                scheduleUpTimer(duration)
                animate()
            }
        case .failed, .cancelled:
            startTop = 0
            scheduleUpTimer(2.0)
        case .possible: break
        }
    }
    
    @objc private func applicationDidEnterBackground(_ notification: Notification) {
        stopUpTimer()
        removeFromSuperview()
    }
    
    @objc private func deviceOrientationDidChange(_ notification: Notification) {
        updateHeight()
    }
    
    // MARK: - Private -
    
    private func setup(_ status: String, type: DropAppearance) {
        self.translatesAutoresizingMaskIntoConstraints = false
        var labelContainer: UIView = self
        
        addBackground(with: type.backgroundColor)
        
        if let blurEffect = type.blurEffect {
            let contentView = addBlurEffect(blurEffect)
            labelContainer = contentView
        }
        
        addStatusLabel(with: status, for: type, to: labelContainer)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceOrientationDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
        
        self.layoutIfNeeded()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(up(_:))))
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan)))
    }
    
    private func addBackground(with color: UIColor?) {
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.backgroundColor = color
        addSubview(backgroundView)
        backgroundView.constraintInsideSuperview(topOffset: -UIScreen.main.bounds.height)
    }
    
    private func addBlurEffect(_ effect: UIBlurEffect) -> UIView {
        let visualEffectView = UIVisualEffectView(effect: effect)
        addSubview(visualEffectView)
        visualEffectView.constraintInsideSuperview(topOffset: -UIScreen.main.bounds.height)
        
        let vibrancyEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: effect))
        visualEffectView.contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.constraintInsideSuperview()
        
        return vibrancyEffectView.contentView
    }
    
    private func addStatusLabel(with status: String, for type: DropAppearance, to container: UIView) {
        statusLabel = makeStatusLabel(with: status, for: type)
        guard let statusLabel = statusLabel else { return }
        container.addSubview(statusLabel)
        statusLabel.pinToSuperviewBottomUsingSideMargins(bottomOffset: -Defaults.bottomMargin)
    }
    
    private func makeStatusLabel(with status: String, for type: DropAppearance) -> UILabel {
        let statusLabel = UILabel(frame: CGRect.zero)
        statusLabel.numberOfLines = 0
        statusLabel.font = type.font ?? Defaults.statusLabelFont
        statusLabel.textAlignment = type.textAlignment ?? .center
        statusLabel.textColor = type.textColor ?? .white
        statusLabel.text = status
        
        return statusLabel
    }
    
    private func updateHeight() {
        var height: CGFloat = 0.0
        height += UIApplication.shared.statusBarFrame.height
        height += Defaults.topMargin
        height += statusLabel?.frame.size.height ?? 0
        height += Defaults.bottomMargin
        
        heightConstraint?.constant = max(height, minimumHeight)
        layoutIfNeeded()
    }
    
    private func constraint(inside container: UIView) {
        leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 100)
        heightConstraint?.isActive = true
        topConstraint = topAnchor.constraint(equalTo: container.topAnchor, constant: -(heightConstraint?.constant ?? 0))
        topConstraint?.isActive = true
    }
    
    private func animate(to topConstant: CGFloat = 0, completion: ((Bool) -> Void)? = nil) {
        topConstraint?.constant = topConstant
        UIView.animate(
            withDuration: Defaults.animationDuration,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseOut],
            animations: {
                self.superview?.layoutIfNeeded()
        }, completion: completion)
    }
    
    // MARK: Timer
    
    @objc private func upFromTimer(_ timer: Timer) {
        Drop.up(self)
    }
    
    private func scheduleUpTimer(_ after: Double) {
        stopUpTimer()
        upTimer = Timer.scheduledTimer(timeInterval: after, target: self, selector: #selector(upFromTimer), userInfo: nil, repeats: false)
    }
    
    private func stopUpTimer() {
        upTimer?.invalidate()
        upTimer = nil
    }
}

// MARK: - Static -

extension Drop {
    
    class func show(_ status: String, type: DropAppearance, duration: Double, action: DropAction?) {
        upAll()
        
        let drop = Drop(duration: duration)
        UIApplication.shared.keyWindow?.addSubview(drop)
        guard let window = drop.window else { return }
        drop.constraint(inside: window)
        
        drop.setup(status, type: type)
        drop.action = action
        drop.updateHeight()
        
        down(drop)
    }
    
    class func down(_ drop: Drop) {
        drop.superview?.layoutIfNeeded()
        drop.animate()
    }
    
    class func up(_ drop: Drop) {
        guard let heightConstant = drop.heightConstraint?.constant else { return }
        
        drop.animate(to: -heightConstant) { [weak drop] (_) in
            drop?.removeFromSuperview()
        }
    }
}
