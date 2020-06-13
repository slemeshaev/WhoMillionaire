//
//  Observable.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 13.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class Observable<Type> {
    
    fileprivate class Callback {
        fileprivate weak var observer: AnyObject?
        fileprivate let options: [ObservableOptions]
        fileprivate let closure: (Type, ObservableOptions) -> Void

        fileprivate init(observer: AnyObject, options: [ObservableOptions], closure: @escaping (Type, ObservableOptions) -> Void) {
            self.observer = observer
            self.options = options
            self.closure = closure
        }
    }

    public var value: Type {
        didSet {
            removeNilObserverCallbacks()
            notifyCallbacks(value: oldValue, option: .old)
            notifyCallbacks(value: value, option: .new)
        }
    }

    public init(_ value: Type) {
        self.value = value
    }

    private var callbacks: [Callback] = []

    public func addObserver(_ observer: AnyObject, removeIfExists: Bool = true, options: [ObservableOptions] = [.new], closure: @escaping (Type, ObservableOptions) -> Void) {
        if removeIfExists {
            removeObserver(observer)
        }
        let callback = Callback(observer: observer, options: options, closure: closure)
        callbacks.append(callback)
        if options.contains(.initial) {
            closure(value, .initial)
        }
    }

    public func removeObserver(_ observer: AnyObject) {
        callbacks = callbacks.filter { $0.observer !== observer }
    }

    private func removeNilObserverCallbacks() {
        callbacks = callbacks.filter { $0.observer != nil }
    }

    private func notifyCallbacks(value: Type, option: ObservableOptions) {
        let callbacksToNotify = callbacks.filter {
            $0.options.contains(option)
        }
        callbacksToNotify.forEach { $0.closure(value, option) }
    }
}
