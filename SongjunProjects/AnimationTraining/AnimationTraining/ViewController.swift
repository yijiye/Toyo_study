//
//  ViewController.swift
//  AnimationTraining
//
//  Created by kimseongjun on 2023/04/28.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yagom")
        
        return imageView
    }()
    
    
    let errorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("에러를 만난 야곰", for: .normal)
        button.addTarget(self, action: #selector(pushError), for: .touchUpInside)
        
        return button
    }()
    
    @objc func pushError() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse]) {
            self.imageView.frame = self.imageView.frame.offsetBy(dx: -10, dy: 0)
        } completion: { completion in
            self.imageView.frame = self.imageView.frame.offsetBy(dx: 10, dy: 0)
        }
    }
    
    let newMacButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("새 맥북을 구매한 야곰", for: .normal)
        button.addTarget(self, action: #selector(pushNewMac), for: .touchUpInside)
        return button
    }()
    
    @objc func pushNewMac() {
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [.repeat, .autoreverse]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2) {
                self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 1.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2) {
                self.imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.0)
            }
        }
    }
    
    
    let customButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Custom", for: .normal)
        
        return button
    }()
    
    let returnButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("되돌리기", for: .normal)
        button.addTarget(self, action: #selector(pushReturn), for: .touchUpInside)
        return button
    }()
    
    @objc func pushReturn() {
        self.imageView.layer.removeAllAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        // Do any additional setup after loading the view.
    }
    
    private func configureLayout() {
        view.addSubview(imageView)
        view.addSubview(errorButton)
        view.addSubview(newMacButton)
        view.addSubview(customButton)
        view.addSubview(returnButton)
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.height.width.equalTo(200)
        }
        
        errorButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(80)
            $0.height.equalTo(80)
            $0.width.equalTo(200)
        }
        newMacButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(errorButton.snp.bottom).offset(10)
            $0.height.equalTo(80)
            $0.width.equalTo(200)
        }
        customButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(newMacButton.snp.bottom).offset(10)
            $0.height.equalTo(80)
            $0.width.equalTo(200)
        }
        returnButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(customButton.snp.bottom).offset(10)
            $0.height.equalTo(80)
            $0.width.equalTo(200)
        }
    }
}

/*
 Rectangle()
 .frame(width: 100, height: 100)
 .foregroundColor(.blue)
 .offset(x: xOffset)
 .animation(Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: true))
 .onAppear {
 self.xOffset = -10
 }
 */
