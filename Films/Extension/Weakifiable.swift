import Foundation

protocol Weakifiable: class { }

extension Weakifiable {
    func weak(_ closure: @escaping (Self) -> () -> Void) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)()
        }
    }
    
    func weak<T>(_ closure: @escaping (Self) -> () -> T?) -> () -> T? {
        return { [weak self] in
            guard let self = self else { return nil }
            return closure(self)()
        }
    }
    
    func weak<T>(_ closure: @escaping (Self) -> (T) -> Void) -> (T) -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)($0)
        }
    }
    
    func weak<T, U>(_ closure: @escaping (Self) -> (T, U) -> Void) -> (T, U) -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)($0, $1)
        }
    }
    
    func weak<T, U, V>(_ closure: @escaping (Self) -> (T, U, V) -> Void) -> (T, U, V) -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)($0, $1, $2)
        }
    }
    
    func weak<T, Z>(_ closure: @escaping (Self) -> (T) -> Z?) -> (T) -> Z? {
        return { [weak self] in
            guard let self = self else { return nil }
            return closure(self)($0)
        }
    }
    
    func weak<T, U, Z>(_ closure: @escaping (Self) -> (T, U) -> Z?) -> (T, U) -> Z? {
        return { [weak self] in
            guard let self = self else { return nil }
            return closure(self)($0, $1)
        }
    }
    
    func weak<T, U, V, Z>(_ closure: @escaping (Self) -> (T, U, V) -> Z?) -> (T, U, V) -> Z? {
        return { [weak self] in
            guard let self = self else { return nil }
            return closure(self)($0, $1, $2)
        }
    }
    
    func weak<T, U>(_ closure: @escaping (Self) -> (T, U) -> Void, _ argument: U) -> (T) -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)($0, argument)
        }
    }
    
    func weak<T, U, Z>(_ closure: @escaping (Self) -> (T, U, Z) -> Void, _ argumentU: U, _ argumentZ: Z) -> (T) -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)($0, argumentU, argumentZ)
        }
    }
    
    func weak<T>(_ closure: @escaping (Self) -> (T) -> Void, _ argument: T) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            return closure(self)(argument)
        }
    }
}
