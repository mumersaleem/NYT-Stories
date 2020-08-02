//
//  Observable.swift
//  nyt
//
//  Created by Umer Saleem on 28/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> ())?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> ()) {
        closure(value)
        listener = closure
    }
}
