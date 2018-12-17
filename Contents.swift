import UIKit

var str = "Hello, playground"

let person=[["name":"xiaohong","age":14],["name":"mimi","age":20]]
let name=person.map{$0["name"]!}
print("名字为 ==\(name)")


let aa=["sfdsf","a","熊欢","1234"]
let prepareint=aa.filter{Int($0) != nil}
print(prepareint)


let contact=aa.reduce(""){$0+$1+","}
//let contact=aa.reduce("",{$0+$1","})
print(contact)


let nums=[1,2,3,4,5,6]
let total=nums.reduce(0){$0+$1}
let min=nums.reduce(nums[0]){$0>$1 ?$1:$0}
let max=nums.reduce(nums[0]){$0<$1 ?$1:$0}
print("min is \(min)")
print("max is \(max)")
print("sum is \(total)")

func f1(a: Int) -> Int {
    return a
}  //函数类型为(Int) -> Int

func f2(a: String) -> Int {
    return Int(a)!
}  //函数类型为(String) -> Int

func f3() -> Int {
    return 2
}  //函数类型为() -> Int

func f4(a: Int) {
    
}  //函数类型为(Int) -> Void

func f5(a: Int) -> Int {
    return a + 1
}  //函数类型为(Int) -> Int

let funArr: [Any] = [f1, f2, f3, f4, f5]
for (index, value) in funArr.enumerated() { //因为循环过程中需要设计到数组的下标，要将数组元素一一列举出来，所以需要调用数组的enumerated()方法。
    if value is (Int) -> Int {
        print(index)  //输出类型为(Int) -> Int的函数在数组中的下标，
    }
}  //输出结果为0 (换行)  4



extension Int {
    //因为直接使用系统的sqrt(Double)函数会与扩展中定义的函数冲突，所以需要指定系统函数的框架
    
    /// 求平方根
    ///
    /// - Returns: 返回该Int型数据的平方根
    func sqrt() -> Double {
        return Darwin.sqrt(Double(self))
    }
}

print(4.sqrt())  //输出2.0


func isEquals<T: Comparable>(a: [T]) -> (min:T,max:T) {
    var min=a[0]
    var max=a[0]
    for i in a{
        if i < min{
            min=i
        }
        if i > max{
            max=i
        }
        
    }
    return (min,max)
}
print(isEquals(a:[1,2,3,4,5]))
print(isEquals(a:["a","b","c","d"]))

enum Gender{
    case male,female
}
class Person:CustomStringConvertible{
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    var fullName:String {
        return  lastName+firstName //计算属性
    }
    init(firstName:String, lastName:String, age:Int, gender:Gender)
    {
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
        self.gender=gender
    }
    convenience init(firstName:String)
    {
        self.init(firstName:firstName, lastName:"熊", age:20, gender:Gender.female)
    }
    /*func description()->String{
     
     }*/
    var description:String{
        return "Name:\(fullName) Age:\(age) Gender:\(gender)"
        //协议统一实现属性{get} 在xcode中可以jump看到
    }
    static func ==(x:Person,y:Person)->Bool{
        return x.fullName==y.fullName
    }
    static func !=(x:Person,y:Person)->Bool{
        return x.fullName != y.fullName
    }
    func run(){
        print("Person \(fullName) is running")
    }
}
var person1 = Person(firstName:"猫", lastName:"熊", age:20, gender:Gender.female)
var person2 = Person(firstName:"欢")
var person3 = person1
var person4 =  Person(firstName:"猫", lastName:"熊", age:20, gender:Gender.female)
//print(person1.description)
//print(person2.description)
if( person1 === person3)
{
    print("地址相同")
}
if(person1 == person4)
{
    print("姓名相同")
}
if(person1 != person2)
{
    print("姓名不同")
}
print(person4)
enum Department{
    case Maths,Chinese
}

protocol SchoolProtocol{
    var depart:Department{get}
    func lendBook()//不修改不加mutating
    
}
class Teacher:Person ,SchoolProtocol{
    var title:String
    var depart:Department
    init(firstName:String, lastName:String, age:Int, gender:Gender,title:String,depart:Department)
    {
        self.title=title
        self.depart=depart
        super.init(firstName:firstName, lastName:lastName, age:age, gender:gender)
    }
    convenience init(firstName:String)
    {
        self.init(firstName:firstName, lastName:"陈", age:40, gender:Gender.male,title:"特级教师",depart: Department.Maths)
    }
    override var description:String{
        return super.description+" title:\(title)"
        //协议统一实现属性{get} 在xcode中可以jump看到
    }
    override func run(){
        print("Teacher \(fullName) is running")
    }
    func lendBook(){//不需override
        print("Teacher \(fullName) WHO IS IN \(depart) is lending book")
    }
    
}
class Student:Person{
    var stuNo:String
    var depart:Department
    init(firstName:String, lastName:String, age:Int, gender:Gender,stuNo:String,depart:Department)
    {
        self.stuNo=stuNo
        self.depart=depart
        super.init(firstName:firstName, lastName:lastName, age:age, gender:gender)
    }
    convenience init(firstName:String)
    {
        self.init(firstName:firstName, lastName:"王", age:17, gender:Gender.male,stuNo:"2016110343",depart: Department.Chinese)
    }
    override var description:String{
        return super.description+" 学号:\(stuNo)"
        //协议统一实现属性{get} 在xcode中可以jump看到
    }
    override func run(){
        print("Student \(fullName) is running")
    }
    func lendBook(){
        print("Student \(fullName) WHO IS IN \(depart) is lending book")
    }
    
    
    
}
let t1=Teacher(firstName:"杰")
let s1=Student(firstName:"一川")
let p1=Person(firstName:"咪")
let p2=Person(firstName:"生")
var persons=[p1,p2,t1,s1]
print(persons)
for i in persons{
    if  let a = i as? Student{//仍然属于person类强制类型转化
        a.run()
        a.lendBook()//这样这个才可以否则只能运行上面的
        
    }else if let a = i as? Teacher{
        a.run()
        a.lendBook()
        
    }else if i is Person{
        i.run()
        
    }
}



