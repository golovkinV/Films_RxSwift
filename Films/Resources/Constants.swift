import UIKit

public typealias ActionFunc = () -> ()
public typealias Action<T> = (T) -> ()
public typealias ActionIO<I, O> = (I) -> (O)
public typealias ActionO<O> = () -> (O)
public typealias Factory<O> = () -> (O)
public typealias ActionHandler<I,O> = (I,O) -> ()

struct Constants {
    struct Strings {
        static let error = "Ошибка"
        static let timers = "Фильмы"
    }
}

