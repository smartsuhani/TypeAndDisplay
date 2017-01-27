import Foundation

public class nameit{
    var name:String
    public init(name:String){
        self.name = name
    }
    public func take(){
        self.name = readLine()!
    }
    public func put(){
        print(self.name)
    }
}
