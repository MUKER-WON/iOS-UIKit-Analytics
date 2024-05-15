//
//  ViewController.swift
//  iOS-UIKit-Analytics
//
//  Created by Muker on 5/14/24.
//

import UIKit
import FirebaseAnalytics

final class ViewController: UIViewController {
    
    private let navigationCountLabel: UILabel = {
        var label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 100)
        return label
    }()
    
    private lazy var buttonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.title = "다음 페이지"
        return config
    }()
    
    private lazy var nextPageAction = UIAction(
        image: .strokedCheckmark,
        handler: { [weak self] _ in
            self?.navigationController?.pushViewController(
                ViewController(
                    count: String(Int((self?.navigationCountLabel.text)!)! + 1)
                ),
                animated: true
            )
              
            Analytics.logEvent("nextPageAction", parameters: nil)
        }
    )
    
    init(count naviagtionCount: String) {
        self.navigationCountLabel.text = naviagtionCount
        super.init(nibName: nil, bundle: nil)
        
        Analytics.logEvent("View Init", parameters: ["init": #file])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nextPageButton: UIButton = {
        var button = UIButton(
            configuration: buttonConfig,
            primaryAction: nextPageAction
        )
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        [navigationCountLabel, nextPageButton]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview($0)
            }
        NSLayoutConstraint.activate([
            
            navigationCountLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            navigationCountLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            
            nextPageButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
            nextPageButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
        ])
        
    }


}

